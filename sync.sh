#!/usr/bin/env bash
set -eu

syncshsum=$(sha512sum $0)

NO_PULL=
LINK=
FORCE=

while getopts fln OPT
do
    case $OPT in
        f)
            FORCE=1
            ;;
        l)
            LINK=1
            ;;
        n)
            NO_PULL=1
            ;;
    esac
done

if [ ! -f entry.yml ]; then
    echo "entry.yml not found."
    exit 1
fi

POLKADOT_VERSION=0.0.3
OS="$(uname)"
ARCH="$(uname -m)"

if [ ! -f bin/polkadot ]; then
    echo -e "\e[1mbin/polkadot not found.\e[0m"
    case "$OS" in
        Linux|Darwin|Windows)
            : ;;
        MSYS_NT*|MINGW32_NT*)
            OS=Windows ;;
        *)
            echo -n 'please input os (Linux, Darwin, Windows)> '
            read OS ;;
    esac
    if [ -z "$OS" ]; then
        exit 1
    fi
    case "$ARCH" in
        x86_64|arm64|i386)
            : ;;
        amd64)
            ARCH=x86_64 ;;
        *)
            echo 'please input arch (x86_64, arm64, i386)> '
            read ARCH ;;
    esac
    if [ -z "$ARCH" ]; then
        exit 1
    fi
    mkdir -p tmp bin
    ARCHIVE_NAME="polkadot_${POLKADOT_VERSION}_${OS}_${ARCH}.tar.gz"
    URL="https://github.com/taskie/polkadot/releases/download/v${POLKADOT_VERSION}/${ARCHIVE_NAME}"
    echo "downloading ${URL}"
    curl -L -o "tmp/${ARCHIVE_NAME}" "$URL"
    EXE_NAME=polkadot
    if [ "$OS" = Windows ]; then
        EXE_NAME=polkadot.exe
    fi
    tar zxvf "tmp/${ARCHIVE_NAME}" -C bin/ "$EXE_NAME"
    chmod u+x bin/polkadot
    echo "polkadot version"
    if ! bin/polkadot -V; then
        rm -f bin/polkadot
        exit 1
    fi
    rm -f "tmp/${ARCHIVE_NAME}"
fi

if [ -z "$NO_PULL" ]; then
    git pull
    git submodule init
    git submodule sync
    git submodule update
    if ! echo "$syncshsum" | sha512sum -c > /dev/null; then
       echo "sync.sh updated."
       echo "please ./sync.sh again."
       exit 1
    fi
    echo
fi

if [ -x private.sh ]; then
    if [ -n "$NO_PULL" ]; then
        ./private.sh -n
    else
        ./private.sh
    fi
fi

bin/polkadot ./entry.yml public/ private/ local/

rm_fi() {
    if [ -f "$dst" ]; then
        if [ -n "$FORCE" ]; then
            rm -f $@
        else
            rm -i $@
        fi
    fi
}

if [ -n "$LINK" ]; then
    echo
    for file in $(find distribute)
    do
        if [ "$file" == "distribute" -o "$file" == "distribute/.gitkeep" ]; then
            continue
        fi
        src="$(pwd)/$file"
        dst="$HOME/${file##distribute/}"
        if [ -d "$src" ]; then
            echo "mkdir -p $dst"
            rm_fi "$dst"
            mkdir -p "$dst"
        elif [ -s "$src" ]; then
            echo "ln -s $src $dst"
            rm_fi "$dst"
            ln -s "$src" "$dst"
            if [ $(basename $(dirname "$dst")) == "bin" ]; then
                echo "chmod u+x $dst"
                chmod u+x "$dst"
            fi
        fi
    done
fi

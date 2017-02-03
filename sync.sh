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

if [ ! -f bin/polkadot ]; then
    echo -e "\e[1mbin/polkadot not found.\e[0m"
    echo "please input target (linux_amd64, linux_386, linux_arm, darwin_amd64, windows_amd64)"
    echo -n "> "
    read TARGET
    if [ "$TARGET" == windows-amd64 ]; then
        TARGET=windows-amd64.exe
    fi
    if [ -z "$TARGET" ]; then
        exit 1
    fi
    curl -L -o bin/polkadot "https://github.com/taskie/polkadot/releases/download/v0.0.2a/polkadot-0.0.2a-$TARGET"
    chmod u+x bin/polkadot
    echo "polkadot version"
    if ! bin/polkadot -V; then
        rm -f bin/polkadot
        exit 1
    fi
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

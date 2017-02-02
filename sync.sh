#!/usr/bin/env bash
set -eu

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

if [ ! -f bin/polkadot ]; then
    echo "bin/polkadot not found."
    echo "please input target (linux-amd64, linux-386, linux-arm, darwin-amd64, windows-amd64)"
    echo -n "> "
    read TARGET
    if [ "$TARGET" == windows-amd64 ]; then
        TARGET=windows-amd64.exe
    fi
    if [ -z "$TARGET" ]; then
        exit 1
    fi
    curl -L -o bin/polkadot "https://github.com/taskie/polkadot/releases/download/v0.0.1/polkadot-0.0.1-$TARGET"
    chmod u+x bin/polkadot
fi

if [ -z "$NO_PULL" ]; then
    git pull
    git submodule init
    git submodule sync
    git submodule update
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

if [ -n "$LINK" ]; then
    for file in $(find dst)
    do
        if [ "$file" == "dst" -o "$file" == "dst/.gitkeep" ]; then
            continue
        fi
        src="$(pwd)/$file"
        dst="$HOME/${file##dst/}"
        echo "$src -> $dst"
        if [ -d "$src" ]; then
            mkdir -p "$dst"
        elif [ -f "$src" ]; then
            if [ -f "$dst" ]; then
                if [ -n "$FORCE" ]; then
                    rm -f "$dst"
                else
                    rm -i "$dst"
                fi
            fi
            ln -s "$src" "$dst"
        fi

    done
fi

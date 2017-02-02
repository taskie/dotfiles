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

if [ -z "$NO_PULL" ]; then
    git pull
    git submodule init
    git submodule sync
    git submodule update
    echo
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

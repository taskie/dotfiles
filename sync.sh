#!/usr/bin/env bash
set -eu

NO_PULL=

while getopts n OPT
do
    case $OPT in
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

#!/usr/bin/env bash
set -eu

syncshsum="$(sha512sum "$0")"

NO_PULL=
LINK=
FORCE=
PULL_SUBMODULES=

println () {
    printf '%s\n' "$@"
}

log () {
    println "$*" >&2
}

log_fatal () {
    log "$*"
    exit 1
}

while getopts flns OPT; do
    case "$OPT" in
        f)
            FORCE=1 ;;
        l)
            LINK=1 ;;
        n)
            NO_PULL=1 ;;
        s)
            PULL_SUBMODULES=1 ;;
        *)
            log_fatal "illegal flag: ${OPT}" ;;
    esac
done

if [ ! -f entry.yml ]; then
    log "entry.yml not found."
    exit 1
fi

POLKADOT="${POLKADOT:-}"
POLKADOT_VERSION=0.1.0
OS="$(uname)"
ARCH="$(uname -m)"

if [ -z "$POLKADOT" ]; then
    if type polkadot >/dev/null 2>&1; then
        POLKADOT=polkadot
    else
        POLKADOT=bin/polkadot
    fi
fi

if [ "$POLKADOT" = bin/polkadot ] && [ ! -f bin/polkadot ]; then
    log "bin/polkadot not found."
    case "$OS" in
        Linux)
            OS=linux ;;
        Darwin)
            OS=darwin ;;
        Windows|MSYS_NT*|MINGW32_NT*)
            OS=windows ;;
        *)
            printf 'please input os (linux, darwin, windows)> ' >&2
            read -r OS ;;
    esac
    [ -n "$OS" ] || log_fatal "please specify os"
    case "$ARCH" in
        amd64|arm64)
            : ;;
        x86_64)
            ARCH=amd64 ;;
        *)
            printf 'please input arch (amd64, arm64)> ' >&2
            read -r ARCH ;;
    esac
    [ -n "$ARCH" ] || log_fatal "please specify arch"
    mkdir -p tmp bin
    ARCHIVE_NAME="polkadot_${POLKADOT_VERSION}_${OS}_${ARCH}.tar.gz"
    POLKADOT_URL="https://github.com/taskie/polkadot/releases/download/v${POLKADOT_VERSION}/${ARCHIVE_NAME}"
    log "downloading ${POLKADOT_URL}"
    curl -L -o "tmp/${ARCHIVE_NAME}" "$POLKADOT_URL"
    EXE_NAME=polkadot
    if [ "$OS" = Windows ]; then
        EXE_NAME=polkadot.exe
    fi
    tar zxvf "tmp/${ARCHIVE_NAME}" -C bin/ "$EXE_NAME"
    chmod u+x bin/polkadot
    log 'checking polkadot version...'
    if ! bin/polkadot -V; then
        rm -f bin/polkadot
        log_fatal 'cannot launch polkadot'
    fi
    rm -f "tmp/${ARCHIVE_NAME}"
fi

if [ -z "$NO_PULL" ]; then
    git pull
    git submodule init
    git submodule sync
    git submodule update
    if [ -n "$PULL_SUBMODULES" ]; then
        git submodule foreach git pull origin master
    fi
    if ! println "$syncshsum" | sha512sum -c > /dev/null; then
        log "sync.sh was updated."
        log "please ./sync.sh again."
        exit 1
    fi
fi

if [ -x private.sh ]; then
    if [ -n "$NO_PULL" ]; then
        ./private.sh -n
    else
        ./private.sh
    fi
fi

LAYERS='public/ private/ local/'
if [ -f layers.txt ]; then
    LAYERS="$(tr '[\n]' '[ ]' <./layers.txt)"
fi
"$POLKADOT" ./entry.yml $LAYERS

rm_fi() {
    if [ -f "$dst" ]; then
        if [ -n "$FORCE" ]; then
            rm -f "$@"
        else
            rm -i "$@"
        fi
    fi
}

if [ -n "$LINK" ]; then
    find distribute | while read -r file; do
        if [ "$file" == "distribute" ] || [ "$file" == "distribute/.gitkeep" ]; then
            continue
        fi
        src="$(pwd)/$file"
        dst="$HOME/${file##distribute/}"
        if [ -d "$src" ]; then
            log "mkdir -p $dst"
            rm_fi "$dst"
            mkdir -p "$dst"
        elif [ -s "$src" ]; then
            log "ln -s $src $dst"
            rm_fi "$dst"
            ln -s "$src" "$dst"
            if [ "$(basename "$(dirname "$dst")")" == bin ]; then
                log "chmod u+x $dst"
                chmod u+x "$dst"
            fi
        fi
    done
fi

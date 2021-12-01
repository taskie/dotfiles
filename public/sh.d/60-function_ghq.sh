cdq() {
    _cdq_dir="$(ghq list --full-path | "$FILTER" -q "$*")"
    if [ ! -d "$_cdq_dir" ]; then
        return 1
    fi
    cd "$_cdq_dir" || return 1
}

alias q=cdq

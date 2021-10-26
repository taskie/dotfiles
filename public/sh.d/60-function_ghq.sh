cdq () {
    cdq_dir="$(ghq list --full-path | "$FILTER" -q "$*")"
    if [ ! -d "$cdq_dir" ]; then
        return 1
    fi
    cd "$cdq_dir"
}

alias q=cdq

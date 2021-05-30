cdq () {
    gh_dir="$(ghq list --full-path | fzf -q "$*")"
    if [ -d "$gh_dir" ]; then
        cd "$gh_dir"
    fi
    return 1
}

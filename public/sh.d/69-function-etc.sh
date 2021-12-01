jqc() {
    jq -C "$@" | less -RS
}

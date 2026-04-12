jqc() {
    jq -C "$@" | less -RS
}

{{if .emacsd}}
sude() {
    emacsclient -nw "/sudo::$(realpath "$1")"
}
{{end}}

{{if .gh}}
ghb() {
    gh browse -b "$(git branch --show-current)" "$@"
}
{{end}}

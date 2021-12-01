sude() {
    _sude_file="$(realpath "$1")"
    shift
    emacsclient -nw "/sudo::${_sude_file}"
}

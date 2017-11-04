sude () {
    file="$(realpath $1)"
    shift
    emacsclient -nw "/sudo::$1"
}

# http://futurismo.biz/archives/2514
{{if .ag}}
function agf() {
    if (( ! $# )); then
        return 1
    fi
    local list
    list="$(
        ag --color $@ \
            | "$FILTER" --ansi --query "$LBUFFER" \
            | awk -F : '{print "+" $2 " " $1}'
    )"
    if (( $? == 0 )) && [[ -n $list ]]; then
        printf '%s\n' "$list" | xargs -r ${=EDITOR}
    fi
}
{{end}}

{{if .rg}}
function rgf() {
    if (( ! $# )); then
        return 1
    fi
    local list
{{if .delta}}
    list="$(
        rg -n --json $@ \
            | delta --grep-output-type classic \
            | "$FILTER" --ansi --query "$LBUFFER" \
            | awk -F : '{print "+" $2 " " $1}'
    )"
{{else}}
    list="$(
        rg -n --color ansi $@ \
            | "$FILTER" --ansi --query "$LBUFFER" \
            | awk -F : '{print "+" $2 " " $1}'
    )"
{{end}}
    if (( $? == 0 )) && [[ -n $list ]]; then
        printf '%s\n' "$list" | xargs -r ${=EDITOR}
    fi
}
alias s=rgf

function rgdelta() {
    if (( ! $# )); then
        return 1
    fi
    rg --json "$@" | delta
}
alias d=rgdelta
{{end}}

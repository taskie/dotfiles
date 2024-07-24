{{if .fd}}
function cdf() {
    local list
    list=$(
        fd --color always -t d $@ \
            | "$FILTER" --ansi --query "$LBUFFER"
    )
    if (( $? == 0 )) && [[ -n $list ]]; then
        cd "$list"
    fi
}
alias a=cdf

function fdf() {
    local list
    list=$(
        fd --color always -t f $@ \
            | "$FILTER" --ansi --query "$LBUFFER"
    )
    if (( $? == 0 )) && [[ -n $list ]]; then
        printf '%s\n' "$list" >&2
        printf '%s\n' "$list" | xargs -r ${=EDITOR}
    fi
}
alias z=fdf
{{end}}

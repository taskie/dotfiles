{{if .fd}}
function fdf() {
  list=$(fd --color always $@ \
           | "$FILTER" --ansi --query "$LBUFFER")
  if (( $? == 0 )) && [[ -n $list ]]; then
    printf '%s\n' "$list" | xargs -r ${=EDITOR}
  fi
}
alias a=fdf
{{end}}

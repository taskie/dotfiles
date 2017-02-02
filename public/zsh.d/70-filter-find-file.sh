# http://futurismo.biz/archives/2514
function filter-find-file () {
    command ls | $FILTER | xargs ${=EDITOR}
    zle reset-prompt
}
zle -N filter-find-file
bindkey '^x^f' filter-find-file

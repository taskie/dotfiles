# == filter ==

# 最近ナウイpecoを試してみたメモ | Futurismo
# https://futurismo.biz/archives/2514/

function filter-find-file () {
    command ls | $FILTER | xargs ${=EDITOR}
    zle reset-prompt
}

zle -N filter-find-file

bindkey '^x^f' filter-find-file

function filter-select-history() {
    BUFFER=$(fc -lnr 1 | awk '!seen[$0]++' | "$FILTER" --query "$LBUFFER" --no-sort)
    CURSOR=${#BUFFER}
    zle redisplay
}

zle -N filter-select-history

bindkey '^r' filter-select-history

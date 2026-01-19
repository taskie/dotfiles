# == enter ==

# Enter で ls と git status を表示すると便利 - Qiita
# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d

function _do_enter() {
    if [[ -z $BUFFER ]]; then
        BUFFER=' @'
    fi
    zle accept-line
    return 0
}

zle -N _do_enter

bindkey '^m' _do_enter

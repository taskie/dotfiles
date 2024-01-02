# == enter ==

# Enter で ls と git status を表示すると便利 - Qiita
# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
function do-enter() {
    if [[ -n $BUFFER ]]; then
        zle accept-line
        return 0
    fi
    echo
    ls_abbrev

    vcs_status
    echo
    echo
    echo
    zle reset-prompt
    return 0
}

zle -N do-enter

bindkey '^m' do-enter

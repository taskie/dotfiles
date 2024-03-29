# == prompt ==

# zsh の vcs_info に独自の処理を追加して stash 数とか push していない件数とか何でも表示する - Qiita
# http://qiita.com/mollifier/items/8d5a627d773758dd8078

autoload -Uz vcs_info
autoload -Uz add-zsh-hook

setopt NO_promptcr   # 出力の文字列末尾に改行コードが無い場合でも表示
setopt prompt_subst  # 色を使う

# left prompt

typeset -i _PROMPT_ENABLED=1

_PROMPT_LAST_STATUS=''

_PROMPT_FORMAT='
%F{{"{"}}{{.color}}{{"}"}}[ %D{%Y-%m-%d %H:%M:%S} ]%f${_PROMPT_LAST_STATUS}
%B%K{{"{"}}{{.color}}{{"}"}}%F{black}  %n@%m:%~  %k%f%b
%F{{"{"}}{{.color}}{{"}"}}{{.prompt}}%f '

PROMPT="$_PROMPT_FORMAT"

add-zsh-hook precmd _update_left_prompt

function _update_left_prompt() {
    local st=$?
    _PROMPT_LAST_STATUS=''
    if (( st != 0 )); then
        _PROMPT_LAST_STATUS=" %F{red}($st)%f"
    fi
}

function prompt-on() {
    _PROMPT_ENABLED=1
    PROMPT="$_PROMPT_FORMAT"
}

function prompt-off() {
    _PROMPT_ENABLED=0
    PROMPT="{{.prompt}} "
}

# right prompt

# vcs_info 設定

RPROMPT=''

# 以下の3つのメッセージをエクスポートする
#   $vcs_info_msg_0_ : 通常メッセージ用 (緑)
#   $vcs_info_msg_1_ : 警告メッセージ用 (黄色)
#   $vcs_info_msg_2_ : エラーメッセージ用 (赤)
zstyle ':vcs_info:*' max-exports 3

zstyle ':vcs_info:*' enable git hg svn bzr cvs
# 標準のフォーマット(git 以外で使用)
# misc(%m) は通常は空文字列に置き換えられる
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

# git 用のフォーマット
# git のときはステージしているかどうかを表示
zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列

# hooks 設定

# git のときはフック関数を設定する

# formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
# のメッセージを設定する直前のフック関数
# 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
# 各関数が最大3回呼び出される。
zstyle ':vcs_info:git+set-message:*' hooks \
    git-hook-begin \
    git-untracked \
    git-push-status \
    git-nomerge-branch \
    git-stash-count

# フックの最初の関数
# git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
# (.git ディレクトリ内にいるときは呼び出さない)
# .git ディレクトリ内では git status --porcelain などがエラーになるため
function +vi-git-hook-begin() {
    if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
        # 0以外を返すとそれ以降のフック関数は呼び出されない
        return 1
    fi

    return 0
}

# untracked ファイル表示
#
# untracked ファイル(バージョン管理されていないファイル)がある場合は
# unstaged (%u) に ? を表示
function +vi-git-untracked() {
    # zstyle formats, actionformats の2番目のメッセージのみ対象にする
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    if command git status --porcelain 2> /dev/null \
        | awk '{print $1}' \
        | command grep -F '??' > /dev/null 2>&1; then

        # unstaged (%u) に追加
        hook_com[unstaged]+='?'
    fi
}

# push していないコミットの件数表示
#
# リモートリポジトリに push していないコミットの件数を
# pN という形式で misc (%m) に表示する
function +vi-git-push-status() {
    # zstyle formats, actionformats の2番目のメッセージのみ対象にする
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    if [[ "${hook_com[branch]}" != "master" ]]; then
        # master ブランチでない場合は何もしない
        return 0
    fi

    # push していないコミット数を取得する
    local ahead
    ahead=$(
        command git rev-list origin/master..master 2>/dev/null \
            | wc -l \
            | tr -d ' '
    )

    if [[ "$ahead" -gt 0 ]]; then
        # misc (%m) に追加
        hook_com[misc]+="(p${ahead})"
    fi
}

# マージしていない件数表示
#
# master 以外のブランチにいる場合に、
# 現在のブランチ上でまだ master にマージしていないコミットの件数を
# (mN) という形式で misc (%m) に表示
function +vi-git-nomerge-branch() {
    # zstyle formats, actionformats の2番目のメッセージのみ対象にする
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    if [[ "${hook_com[branch]}" == "master" ]]; then
        # master ブランチの場合は何もしない
        return 0
    fi

    local nomerged
    nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

    if [[ "$nomerged" -gt 0 ]] ; then
        # misc (%m) に追加
        hook_com[misc]+="(m${nomerged})"
    fi
}


# stash 件数表示
#
# stash している場合は :SN という形式で misc (%m) に表示
function +vi-git-stash-count() {
    # zstyle formats, actionformats の2番目のメッセージのみ対象にする
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    local stash
    stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
    if [[ "${stash}" -gt 0 ]]; then
        # misc (%m) に追加
        hook_com[misc]+=":S${stash}"
    fi
}

typeset -i _RPROMPT_ENABLED=1

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=C.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # vcs_info で何も取得していない場合はプロンプトを表示しない
        prompt=''
    else
        # vcs_info で情報を取得した場合
        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
        # それぞれ緑、黄色、赤で表示する
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # 間にスペースを入れて連結する
        prompt="${(j: :)messages}"
    fi

    if (( _PROMPT_ENABLED && _RPROMPT_ENABLED )); then
        RPROMPT="$prompt"
    else
        RPROMPT=''
    fi
}

function rprompt-on() {
    _RPROMPT_ENABLED=1
    _update_vcs_info_msg
}

function rprompt-off() {
    _RPROMPT_ENABLED=0
    RPROMPT=''
}

add-zsh-hook precmd _update_vcs_info_msg

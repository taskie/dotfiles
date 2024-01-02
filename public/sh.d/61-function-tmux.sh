alias td='tmux detach'

ta() {
    if tmux has-session; then
        tmux attach
    else
        tmux new-session
    fi
}

tt() {
    if [ -n "$TMUX" ]; then
        echo "cannot tt in tmux session"
    else
        if type "$FILTER" >/dev/null 2>&1; then
            _tt_session="$(tmux ls | "$FILTER" | cut -d : -f 1)"
            if [ -z "$_tt_session" ]; then
                tmux new-session
            else
                tmux attach -t "$_tt_session"
            fi
        else
            tmux list-sessions
        fi
    fi
}

# tmuxでSSH時に変更したwindow-nameを自動でもとに戻す - Qiita
# http://qiita.com/yuku_t/items/4ffaa516914e7426419a

ssh() {
    if [ -n "$TMUX" ]; then
        _ssh_window_name=$(tmux display -p '#W')
        _ssh_window_id=$(tmux display -p '#I')
        _ssh_host_like=ssh
        for _ssh_arg in "$@"; do
            _ssh_host_like="${_ssh_arg##*@}"
        done
        tmux rename-window -t "$_ssh_window_id" "<${_ssh_host_like}>"
        command ssh "$@" || :
        tmux rename-window -t "$_ssh_window_id" "$_ssh_window_name"
    else
        command ssh "$@"
    fi
}

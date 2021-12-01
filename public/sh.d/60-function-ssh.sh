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

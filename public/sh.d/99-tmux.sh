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

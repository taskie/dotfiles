function ta () {
    if tmux has-session; then
        tmux attach
    else
        tmux new-session
    fi
}

function tt () {
    if [ -n "$TMUX" ]; then
        echo "cannot tt in tmux session"
    else
        if type $FILTER >/dev/null 2>&1; then
	    session=`tmux ls | $FILTER | awk -F ':' '{print $1}'`
	    if [ -z $session ]; then
	        tmux new-session
	    else
	        tmux attach -t $session
	    fi
        else
	    tmux list-sessions
        fi
    fi
}

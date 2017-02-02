agent="$HOME/.ssh/.ssh-agent-$USER"
if [ -S "$SSH_AUTH_SOCK" ]; then
    if [ ! -L "$SSH_AUTH_SOCK" -a -S "$SSH_AUTH_SOCK" ]; then
	ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
    fi
elif [ -S "$agent" ]; then
    export SSH_AUTH_SOCK=$agent
else
    if [ -z "$TMUX" -a -z "$STY" ]; then
	eval `SHELL=bash ssh-agent`
	ssh-add
    fi
fi

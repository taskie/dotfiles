agent="$HOME/.ssh/.ssh-agent-$USER"

if [ -S "$agent" ]; then
    # echo "$agent is socket"
    export SSH_AUTH_SOCK=$agent
elif [ -S "$SSH_AUTH_SOCK" ]; then
    # echo "$SSH_AUTH_SOCK is socket"
    if [ ! -L "$SSH_AUTH_SOCK" ]; then
        # echo "$SSH_AUTH_SOCK is not symlink"
	ln -snf "$SSH_AUTH_SOCK" "$agent" && export SSH_AUTH_SOCK="$agent"
    fi
else
    if [ -z "$TMUX" -a -z "$STY" ]; then
        # echo "export SSH_AUTH_SOCK"
        # eval `gnome-keyring-daemon --start --components=ssh`
	eval `SHELL=bash ssh-agent`
        ln -snf "$SSH_AUTH_SOCK" "$agent" && export SSH_AUTH_SOCK="$agent"
    fi
fi

if ! ssh-add -l 2>&1 >/dev/null; then
    ssh-add
fi

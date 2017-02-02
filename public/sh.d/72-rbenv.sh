if [[ -d ~/.rbenv ]]; then
    export PATH=~/.rbenv/shims:~/.rbenv/bin:"$PATH"

    export RBENV_SHELL=zsh
    local comppath=~/.rbenv/libexec/../completions/rbenv.zsh
    if [[ -f $comppath ]]; then
        source $comppath
    fi
    rbenv rehash 2>/dev/null
    rbenv() {
	local command
	command="$1"
	if [ "$#" -gt 0 ]; then
	    shift
	fi

	case "$command" in
	    rehash|shell)
		eval "`rbenv "sh-$command" "$@"`";;
	    *)
		command rbenv "$command" "$@";;
	esac
    }
fi

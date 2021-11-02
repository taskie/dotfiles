alias ls='{{if .exa}}exa --sort=Name{{else}}ls{{if .mac}} -G{{else}} --color --show-control-chars{{end}}{{end}} -F'

alias la='ls -a'
alias ll='ls -l{{if not .exa}}h{{end}}'
alias lla='ll -a'

ls_abbrev() {
    # for bash or zsh
    local -a ls_cmd=({{if .exa}}exa --sort=Name{{else}}ls{{end}})
    # colorize
    ls_cmd+=({{if or .exa (not .mac)}}--color=always{{else}}-G{{end}})
    # -C : Force multi-column output.
    {{if not .exa}}ls_cmd+=(-C){{end}}
    # -F : Append indicator (one of */=>@|) to entries.
    ls_cmd+=(-F)
    local ls_result
    ls_result="$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS "${ls_cmd[@]}" | sed $'/^\e\[[0-9;]*m$/d')"

    local ls_lines
    ls_lines="$(echo "$ls_result" | wc -l | tr -d ' ')"

    if [ "$ls_lines" -gt 10 ]; then
	echo "$ls_result" | head -n 5
	echo '...'
	echo "$ls_result" | tail -n 5
	echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
	echo "$ls_result"
    fi
}

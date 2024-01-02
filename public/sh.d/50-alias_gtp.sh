# === aliases ===

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias b='bat -p'
alias c='cargo'
alias e="$EDITOR"
alias g='git'

alias sudx='sudo '

alias ls='{{if .exa}}{{.exa}} --sort=Name{{else}}ls{{if .mac}} -G{{else}} --color --show-control-chars{{end}}{{end}} -F'
alias la='ls -a'
alias ll='ls -l{{if not .exa}}h{{end}}'
alias lla='ll -a'

alias rgs='rg --sort path'

{{if .linux}}
alias open='xdg-open'
alias sctl='sudo systemctl'
alias uctl='systemctl --user'
{{end}}

{{if .win}}
alias open='cygstart'
{{end}}

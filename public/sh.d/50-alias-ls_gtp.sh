alias ls='{{if .exa}}exa{{else}}ls{{if .mac}} -G{{else}} --color --show-control-chars{{end}}{{end}} -F'

alias la='ls -a'
alias ll='ls -lh'
alias lla='ls -alh'

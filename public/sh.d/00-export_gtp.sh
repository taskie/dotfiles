export EDITOR='{{if .emacsd}}emacsclient -nw{{else}}vim{{end}}'
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export LANG=ja_JP.UTF-8
export KCODE=u
export TERM=xterm-256color
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
export FILTER="{{if .fzf}}fzf-tmux{{else if .peco}}peco{{end}}"

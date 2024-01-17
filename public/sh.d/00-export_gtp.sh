# === environment variables ===

export EDITOR='{{if .emacsd}}emacsclient -nw{{else}}vim{{end}}'
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export LANG='{{if .lang}}{{.lang}}{{else}}ja_JP.UTF-8{{end}}'
export KCODE=u
export FILTER='{{if .fzf}}fzf-tmux{{end}}'
{{if .term}}
export TERM='{{.term}}'
{{end}}

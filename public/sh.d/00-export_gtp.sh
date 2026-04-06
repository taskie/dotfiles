# === environment variables ===

export EDITOR='{{if .emacsd}}emacsclient -nw{{else}}vim{{end}}'
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"
export LANG='{{if .lang}}{{.lang}}{{else}}ja_JP.UTF-8{{end}}'
export LC_ALL="$LANG"
export KCODE=u
export FILTER='{{if .fzftmux}}{{.fzftmux}}{{else if .fzf}}{{.fzf}}{{end}}'
{{if .term}}
export TERM='{{.term}}'
{{end}}
{{if .colorterm}}
export COLORTERM='{{.colorterm}}'
{{end}}

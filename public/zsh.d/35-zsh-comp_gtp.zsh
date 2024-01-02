# == completion ==

{{if .posix}}
if [[ -d ~/.local/share/zsh/site-functions ]]; then
    fpath=(~/.local/share/zsh/site-functions $fpath)
fi
{{end}}

{{if .mac}}
if [[ -d /usr/local/share/zsh-completions ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
{{end}}

autoload -Uz compinit

compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{{"{"}}{{.color}}{{"}"}}Completing %B%d%b%f'
zstyle ':completion:*:default' menu select=1  # 補完候補のカーソル選択を有効に

eval "$(dircolors)"  # 補完候補の色づけ

export ZLS_COLORS=$LS_COLORS

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename "${HOME}/.zshrc"

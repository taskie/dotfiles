# === functions ===

# chpwd内のlsでファイル数が多い場合に省略表示する - Qiita
# https://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059

ls_abbrev() {
    # for bash or zsh
    local -a ls_cmd=({{if .exa}}{{.exa}} --sort=Name{{else}}ls{{end}})
    # colorize
    ls_cmd+=({{if or .exa (not .mac)}}--color=always{{else}}-G{{end}})
    # -C : Force multi-column output.
    {{if not .exa}}ls_cmd+=(-C){{end}}
    # -F : Append indicator (one of */=>@|) to entries.
    ls_cmd+=(-F)
    local ls_result
    ls_result="$(
        CLICOLOR_FORCE=1 COLUMNS=$COLUMNS "${ls_cmd[@]}" \
            | sed $'/^\e\[[0-9;]*m$/d'
    )"

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

vcs_status() {
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    elif hg root >/dev/null 2>&1; then
        echo -e "\e[0;33m--- hg status ---\e[0m"
        hg status
    elif svn info >/dev/null 2>&1; then
        echo -e "\e[0;33m--- svn status ---\e[0m"
        svn status
    elif [ -d CVS ]; then
        echo -e "\e[0;33m--- cvs status ---\e[0m"
        cvs -q -n update
    fi
}

cdg() {
    cd "$(git rev-parse --show-toplevel)" || return 1
}

{{if .ghq}}
cdq() {
    _cdq_dir="$(ghq list --full-path | "$FILTER" -q "$*")"
    if [ ! -d "$_cdq_dir" ]; then
        return 1
    fi
    cd "$_cdq_dir" || return 1
}

alias q=cdq
{{end}}

{{if .zoxide}}
if [ -n "${ZSH_VERSION:-}" ]; then
    eval "$({{.zoxide}} init --no-cmd zsh)"
elif [ -n "${BASH_VERSION:-}" ]; then
    eval "$({{.zoxide}} init --no-cmd bash)"
fi

alias x=__zoxide_zi
{{end}}

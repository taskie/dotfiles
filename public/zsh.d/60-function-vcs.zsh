function s_abbrev() {
    local s_result
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        s_result=$(COLUMNS=$COLUMNS command git -c color.status=always status -sb | sed $'/^\e\[[0-9;]*m$/d')
    elif hg root >/dev/null 2>&1; then
        echo
        echo -e "\e[0;33m--- hg status ---\e[0m"
        s_result=$(COLUMNS=$COLUMNS command hg --config "extensions.color=" status | sed $'/^\e\[[0-9;]*m$/d')
    fi

    local s_lines=$(echo "$s_result" | wc -l | tr -d ' ')

    if [ $s_lines -gt 10 ]; then
        echo "$s_result" | head -n 5
        echo '...'
        echo "$s_result" | tail -n 5
    else
        echo "$s_result"
    fi
}

vcs_status () {
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

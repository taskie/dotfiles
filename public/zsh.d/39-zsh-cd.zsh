# == cd ==

# zaw.zshで最近移動したディレクトリに移動する - $shibayu36->blog;
# https://blog.shibayu36.org/entry/20120130/1327937835

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook

add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# zshのchpwdの設定 - よんちゅBlog
# http://yonchu.hatenablog.com/entry/20120507/1336409280
function chpwd() {
    ls_abbrev || :
    if [[ -n $TMUX ]]; then
        local wname="`basename \"\`pwd\`\"`"
        tmux rename-window "$wname"
    fi
}

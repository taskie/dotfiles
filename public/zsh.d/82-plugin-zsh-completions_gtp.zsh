if [[ -f "{{.dotfiles}}/submodules/zsh-completions/zsh-completions.plugin.zsh" ]]; then
    source "{{.dotfiles}}/submodules/zsh-completions/zsh-completions.plugin.zsh"
fi

# https://qiita.com/2357gi/items/e4744ccecccf0bfb7137
compdef g=git
compdef sctl=systemctl
compdef uctl=systemctl

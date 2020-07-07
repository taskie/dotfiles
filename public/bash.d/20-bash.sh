bind '"\C-p": history-search-backward'

shopt -s autocd
shopt -s globstar

export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoreboth
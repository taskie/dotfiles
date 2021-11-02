# global alias

alias G='grep'
alias L='less'
alias S='sort'
alias C='cat'
alias H='head'
alias H2='head -n 20'
alias H3='head -n 30'
alias H4='head -n 40'
alias H5='head -n 50'
alias T='tail'
alias T2='tail -n 20'
alias T3='tail -n 30'
alias T4='tail -n 40'
alias T5='tail -n 50'

# extract

function extract() {
    case $1 in
	*.tar.gz|*.tgz) tar xzvf $1 ;;
	*.tar.xz) tar Jxvf $1 ;;
	*.zip) unzip $1 ;;
	*.lzh) lha e $1 ;;
	*.tar.bz2|*.tbz) tar xjvf $1 ;;
	*.tar.Z) tar zxvf $1 ;;
	*.gz) gzip -dc $1 ;;
	*.bz2) bzip2 -dc $1 ;;
	*.Z) uncompress $1 ;;
	*.tar) tar xvf $1 ;;
	*.arj) unarj $1 ;;
    esac
}

alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

# mkcd

function mkcd() {
  mkdir $@ && cd $@;
}

# cd

# http://yonchu.hatenablog.com/entry/20120507/1336409280

chpwd() {
    ls_abbrev || :
    if [[ -n $TMUX ]]; then
	local wname="`basename \"\`pwd\`\"`"
	tmux rename-window "$wname"
    fi
}

# http://qiita.com/yuyuchu3333/items/e9af05670c95e2cc5b4d
function do_enter() {
    if [ -n "$BUFFER" ]; then
	zle accept-line
	return 0
    fi
    echo
    ls_abbrev

    vcs_status
    echo
    echo
    echo
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

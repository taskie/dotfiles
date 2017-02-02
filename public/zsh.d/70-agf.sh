# http://futurismo.biz/archives/2514
if type ag >/dev/null 2>&1; then
    function agf () {
	ag --color $@ | $FILTER --ansi --query "$LBUFFER" | awk -F : '{print "+" $2 " " $1}' | xargs emacsclient -nw
    }
fi

# http://futurismo.biz/archives/2514
if type ag >/dev/null 2>&1; then
    function agf () {
	list=$(ag --color $@ \
	    | "$FZF" --ansi --query "$LBUFFER" \
	    | awk -F : '{print "+" $2 " " $1}')
	if [ $? -eq 0 -a -n "$list" ]; then
	    echo "$list" | xargs emacsclient -nw
	fi
    }
fi

if type rg >/dev/null 2>&1; then
    function rgf () {
	list=$(rg -n --color ansi $@ \
	    | "$FZF" --ansi --query "$LBUFFER" \
	    | awk -F : '{print "+" $2 " " $1}')
	if [ $? -eq 0 -a -n "$list" ]; then
	    echo "$list" | xargs emacsclient -nw
	fi
    }
fi

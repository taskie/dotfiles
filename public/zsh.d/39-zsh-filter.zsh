# == filter ==

# 最近ナウイpecoを試してみたメモ | Futurismo
# https://futurismo.biz/archives/2514/

function filter-find-file () {
    command ls | $FILTER | xargs ${=EDITOR}
    zle reset-prompt
}

zle -N filter-find-file

bindkey '^x^f' filter-find-file

function filter-select-history() {
    BUFFER=$(
        history 1 \
            | sort -k1,1nr \
            | perl -ne '
                BEGIN { my @lines = (); }
                s/^\s*\d+\s*//;
                $in=$_;
                if (!(grep {$in eq $_} @lines)) {
                    push(@lines, $in);
                    print $in;
                }
                ' \
            | $FILTER --query "$LBUFFER" --no-sort
    )
    CURSOR=${#BUFFER}
}

zle -N filter-select-history

bindkey '^r' filter-select-history

function filter-select-history() {
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | $FILTER --query "$LBUFFER")
    CURSOR=${#BUFFER}
}
zle -N filter-select-history
bindkey '^r' filter-select-history

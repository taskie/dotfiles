# http://qiita.com/yuku_t/items/4ffaa516914e7426419a

function ssh() {
    if [ -n "$TMUX" ]; then
	local window_name=$(tmux display -p '#W')
	local window_id=$(tmux display -p '#I')
	tmux rename-window -t $window_id \<${@:$#}\>
	command ssh $@ || :
	tmux rename-window -t $window_id $window_name
    else
	command ssh $@
    fi
}

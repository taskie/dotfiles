# == basic ==

# zsh, tmux, vimで構築する快適なCUI環境 1/3 「zsh」編 - ナレッジエース
# http://n.blueblack.net/articles/2012-07-20_03_comfortable_cui_environment_zsh/

# bash -> zsh 移行レポート - おもてなしの空間
# http://d.hatena.ne.jp/amt/20060804/zsh

# zshの導入から各種設定 - rderaログ
# https://rdera.hatenadiary.org/entry/20100107/1262868778

setopt auto_cd               # ディレクトリ名だけで cd
setopt auto_list             # 補完候補を一覧表示
setopt auto_menu             # TAB で順に補完候補を切り替える
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_pushd            # cd 時に自動で push
setopt auto_resume           # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt brace_ccl             # {a-c} を a b c に展開する機能を使えるようにする
setopt complete_aliases      # エイリアス使用時の補完を有効に
setopt correct               # スペルチェック
setopt equals                # =command を command のパス名に展開する
setopt extended_glob         # ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt list_packed           # 補完候補を詰めて表示
setopt list_types            # 補完候補一覧でファイルの種別をマーク表示
setopt long_list_jobs        # 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt magic_equal_subst     # --prefix=/usr などの = 以降も補完
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt NO_flow_control       # Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt noautoremoveslash     # 最後のスラッシュを自動的に削除しない
setopt nobeep                # ビープを鳴らさない
setopt numeric_glob_sort     # ファイル名の展開で辞書順ではなく数値的にソート
setopt print_eight_bit       # 出力時8ビットを通す
setopt pushd_ignore_dups     # 同じディレクトリを pushd しない

if [[ -n $TMUX || -n $STY ]]; then
    setopt ignoreeof         # C-d を無効に
fi

bindkey -e                   # Emacs風キーバインド

## Did you reboot?:zshキーバインド Shift-tabで補完候補を逆戻りするように設定
## http://blog.livedoor.jp/montz/archives/1541135.html

bindkey "^[[Z" reverse-menu-complete

# == history ==

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt extended_history    # zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt hist_ignore_dups    # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_space   # コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_no_store       # history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_reduce_blanks  # 余分な空白を排除して記録
setopt hist_verify         # ヒストリを呼び出してから実行する間に一旦編集
setopt share_history       # ヒストリを共有

# == history-search-end ==

autoload history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# == select-word-style ==

autoload -Uz select-word-style

select-word-style default

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# == colors ==

autoload -Uz colors

colors

# == zmv ==

autoload zmv

alias zmv='noglob zmv'

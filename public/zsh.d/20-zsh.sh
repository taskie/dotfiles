## zsh, tmux, vimで構築する快適なCUI環境 1/3 「zsh」編 - ナレッジエース 
## http://n.blueblack.net/articles/2012-07-20_03_comfortable_cui_environment_zsh/

## bash -> zsh 移行レポート - おもてなしの空間
## http://d.hatena.ne.jp/amt/20060804/zsh

## zshの導入から各種設定 - rderaログ
## http://d.hatena.ne.jp/rdera/20100107/1262868778

# basic

bindkey -e

## 出力の文字列末尾に改行コードが無い場合でも表示
setopt NO_promptcr
## 色を使う
setopt prompt_subst
## ビープを鳴らさない
setopt nobeep
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## 補完候補を一覧表示
setopt auto_list
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## TAB で順に補完候補を切り替える
setopt auto_menu
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## 出力時8ビットを通す
setopt print_eight_bit
## ディレクトリ名だけで cd
setopt auto_cd
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## スペルチェック
setopt correct
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control
## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 補完候補を詰めて表示
setopt list_packed
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
## エイリアス使用時の補完を有効に
setopt complete_aliases
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
## エイリアス使用時の補完を有効に
setopt complete_aliases

if [ -n "$TMUX" -o -n "$STY" ]; then
    ## C-d を無効に
    setopt ignoreeof
fi

## Did you reboot? : zshキーバインド Shift-tabで補完候補を逆戻りするように設定
## http://blog.livedoor.jp/montz/archives/1541135.html
bindkey "^[[Z" reverse-menu-complete

### history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## ヒストリを共有
setopt share_history
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

## 余分な空白を排除して記録
setopt hist_reduce_blanks

# history-search-end

autoload history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# select-word-style

autoload -Uz select-word-style

select-word-style default

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# colors

autoload -Uz colors
colors

# zmv

autoload zmv
alias zmv='noglob zmv'

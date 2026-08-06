;;; 実行パス設定

;; exec-path は Emacs が外部コマンドを検索する際に使用するディレクトリのリスト
(add-to-list 'exec-path "/usr{{if .bsd}}/local{{end}}/bin")

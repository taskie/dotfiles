;;; その他の基本設定

;; 新しいバージョンのファイルを優先してロード
(setq load-prefer-newer t)

;; インデントにタブを使用しない
(setq-default indent-tabs-mode nil)

;; ファイルを開いたときに前回のカーソル位置を復元
(setq-default save-place t)

;; バックアップファイルを作成しない
(setq-default make-backup-files nil)

;; ファイル末尾に改行を追加
(setq require-final-newline t)

;; 保存前に行末の空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ファイルが外部で変更されたら自動的に再読み込み
(global-auto-revert-mode 1)

;; GCの閾値を10MBに設定してパフォーマンスを向上
(setq gc-cons-threshold 10000000)

;; yes/no を y/n で答えられるように簡略化
(setq use-short-answers t)

;; ファイル保存時に実行権限を自動付与
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)

;; winner-mode: ウィンドウ構成の履歴管理
(winner-mode t)

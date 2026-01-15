;;; バッファ名の重複を識別しやすくする設定

;; uniquify: 同名ファイルを開いた時のバッファ名を区別しやすくする
(use-package uniquify
  :config
  ;; バッファ名の表示形式を設定
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  
  ;; uniquify の対象から除外するバッファ名のパターン（正規表現）
  (setq uniquify-ignore-buffers-re "*[^*]+*")

  ;; icomplete-mode: ミニバッファでの入力補完を強化
  (icomplete-mode 1))

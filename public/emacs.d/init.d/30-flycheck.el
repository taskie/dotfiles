;;; flycheck - リアルタイム構文チェック

(use-package flycheck
  :ensure nil
  :if (package-installed-p 'flycheck)
  :hook (prog-mode . flycheck-mode)
  :diminish flycheck-mode
  :config
  ;; popup-tip が利用可能な場合、エラーメッセージをポップアップ表示
  (when (fboundp 'popup-tip)
    (custom-set-variables
     ;; エラーをポップアップで表示するカスタム関数を設定
     '(flycheck-display-errors-function
       (lambda (errors)
         (let ((messages (mapcar #'flycheck-error-message errors)))
           (popup-tip (mapconcat 'identity messages "\n")))))

     ;; エラー表示までの遅延時間（秒）
     '(flycheck-display-errors-delay 0.5)))

  ;; C-M-n: 次のエラーにジャンプ
  (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
  
  ;; C-M-p: 前のエラーにジャンプ
  (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error))

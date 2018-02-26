(when (require 'flycheck nil t)
  (when (fboundp 'popup-tip)
    (custom-set-variables
     ;; エラーをポップアップで表示
     '(flycheck-display-errors-function
       (lambda (errors)
         (let ((messages (mapcar #'flycheck-error-message errors)))
           (popup-tip (mapconcat 'identity messages "\n")))))
   '(flycheck-display-errors-delay 0.5)))

  (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)

  (when (fboundp #'flycheck-irony-setup)
    (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
  (add-hook 'c-mode-common-hook 'flycheck-mode))

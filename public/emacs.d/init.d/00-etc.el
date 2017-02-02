(setq load-prefer-newer t)
(setq-default indent-tabs-mode nil)
(setq-default save-place t)
(setq-default make-backup-files nil)
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode 1)

(setq gc-cons-threshold 10000000)

;;; 再帰編集中断時の挙動を変更
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

(defalias 'yes-or-no-p 'y-or-n-p)

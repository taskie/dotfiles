;;; https://github.com/ananthakumaran/tide
;;; https://gist.github.com/hgiasac/b8e4f50ea9dc504e3e52163e58872a4e

(when (require 'tide nil t)
  (defun tslint-fix-file ()
    "Tslint fix file."
    (interactive)
    (message (concat "tslint --fixing the file " (buffer-file-name)))
    (shell-command (concat "tslint --fix " (buffer-file-name))))

  (defun tslint-fix-file-and-revert ()
    "Format the current file with TSLint."
    (interactive)
    (when (or (eq major-mode 'typescript-mode)
              (and (eq major-mode 'web-mode)
                   (string-equal "tsx" (file-name-extension buffer-file-name))))
      (if (executable-find "tslint")
          (tslint-fix-file)
        (message "TSLint not found."))))

  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    ;; company is an optional dependency. You have to
    ;; install it separately via package-install
    ;; `M-x package-install [ret] company`
    (company-mode +1))

  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)

  ;; formats the buffer before saving
  ;; (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'after-save-hook 'tslint-fix-file-and-revert)

  (add-hook 'typescript-mode-hook #'setup-tide-mode)

  (when (require 'web-mode nil t)
    (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
    (add-hook 'web-mode-hook
              (lambda ()
                (when (string-equal "tsx" (file-name-extension buffer-file-name))
                  (setup-tide-mode))))
    ;; enable typescript-tslint checker
    (flycheck-add-mode 'typescript-tslint 'web-mode)))

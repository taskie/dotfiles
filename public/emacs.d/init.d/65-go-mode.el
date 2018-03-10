(when (require 'company-go nil t)
  (add-hook 'go-mode-hook 'company-mode)
  (add-hook 'go-mode-hook 'flycheck-mode)
  (when (require 'flycheck-gometalinter nil t)
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))
    (setq flycheck-gometalinter-fast t))
  (defun my-setup-go-mode ()
    (interactive)
    (add-hook 'before-save-hook 'gofmt-before-save)
    (local-set-key (kbd "M-.") 'godef-jump)
    (set (make-local-variable 'company-backends) '(company-go))
    (setq
     indent-tabs-mode t
     c-basic-offset 2
     default-tab-width 2)
    (company-mode))
  (add-hook 'go-mode-hook 'my-setup-go-mode))

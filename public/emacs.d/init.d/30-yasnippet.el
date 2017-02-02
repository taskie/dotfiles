(when (require 'yasnippet nil t)
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"))

  (yas-global-mode 1)

  (custom-set-variables '(yas-trigger-key "C-TAB"))

  (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
  (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
  (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

  (add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode)))

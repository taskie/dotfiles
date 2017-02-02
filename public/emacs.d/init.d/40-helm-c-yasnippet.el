(when (require 'helm-c-yasnippet nil t)
  (define-key yas-minor-mode-map (kbd "C-x i i") 'helm-c-yas-complete)
  (define-key yas-minor-mode-map (kbd "C-x i v") 'helm-c-yas-visit-snippet-file))

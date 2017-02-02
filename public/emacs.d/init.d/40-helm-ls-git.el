(when (require 'helm-ls-git nil t)
  (global-set-key (kbd "C-x C-d") 'helm-browse-project))

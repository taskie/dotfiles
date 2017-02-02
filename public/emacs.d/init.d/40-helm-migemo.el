(when (executable-find "cmigemo")
  (require 'helm-migemo nil t)
  (setq helm-use-migemo t))

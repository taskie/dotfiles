(when (executable-find "cmigemo")
  (when (require 'helm-migemo nil t)
    (setq helm-use-migemo t)))

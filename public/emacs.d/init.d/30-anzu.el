(when (require 'anzu nil t)

  (custom-set-variables
   '(anzu-mode-lighter "")
   '(anzu-deactivate-region t)
   '(anzu-search-threshold 1000)
   '(anzu-use-migemo (executable-find "cmigemo")))

  (global-anzu-mode 1))

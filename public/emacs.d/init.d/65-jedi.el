(when (require 'jedi-core nil t)

  (setq jedi:complete-on-dot t)
  (setq jedi:use-shortcuts t)
  (add-hook 'python-mode-hook 'jedi:setup)

  ;; backendに追加
  (add-to-list 'company-backends 'company-jedi))

(when (require 'typescript nil t)
  (add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))

  (add-to-list 'exec-path "/usr/local/share/npm/bin")
  ;; (require 'tss)
  ;; (setq tss-popup-help-key "C-:")
  ;; (setq tss-jump-to-definition-key "C->")
  ;; (tss-config-default)
  )

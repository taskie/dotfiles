(setq evil-default-state 'emacs)
(when (require 'evil nil t)
  (evil-mode 1)
  (evil-change-state 'emacs))

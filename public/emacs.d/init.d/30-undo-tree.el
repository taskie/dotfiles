(when (require 'undo-tree nil t)

 (when (version-list-<= '(24 3) (version-to-list emacs-version))
   (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undohist")))
   (setq undo-tree-auto-save-history t))

 (global-undo-tree-mode))

;;; eglot - LSPクライアント

(use-package eglot
  :ensure nil
  :if (package-installed-p 'eglot)
  :hook
  (sh-mode . eglot-ensure)
  (python-mode . eglot-ensure))

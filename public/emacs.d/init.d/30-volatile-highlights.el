;;; volatile-highlights - 編集箇所を一時的にハイライト表示する

(use-package volatile-highlights
  :ensure nil
  :if (package-installed-p 'volatile-highlights)
  :config
  (volatile-highlights-mode t))

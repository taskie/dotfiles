;;; counsel - Ivy を使用した便利なコマンド群を提供

(use-package counsel
  :ensure nil
  :if (package-installed-p 'counsel)
  :diminish counsel-mode
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "C-x C-r") 'counsel-recentf)
  (global-set-key (kbd "C-x C-b") 'counsel-ibuffer)
  (global-set-key (kbd "C-M-z") 'counsel-fzf)
  (global-set-key (kbd "C-M-f") 'counsel-rg)

  ;; counsel-mode を全体で有効化
  (counsel-mode 1))

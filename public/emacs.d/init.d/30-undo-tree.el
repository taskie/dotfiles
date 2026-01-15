;;; undo-tree - Undo/Redoを木構造で管理

(use-package undo-tree
  :ensure nil
  :if (package-installed-p 'undo-tree)
  :diminish undo-tree-mode
  :config
  ;; アンドゥ履歴ファイルの保存先ディレクトリを指定
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undohist")))
  
  ;; ファイル保存時にアンドゥ履歴も自動保存
  (setq undo-tree-auto-save-history t)

  ;; すべてのバッファで undo-tree モードを有効化
  (global-undo-tree-mode))

(defun my-install ()
  (interactive)

  (defvar installing-package-list
    '(
      diminish
      popup

      counsel
      ivy
      ivy-hydrax
      swiper

      magit
      popwin
      recentf-ext
      sequential-command
      undo-tree
      volatile-highlights

      markdown-mode

      {{if .allplugins}}
      flycheck

      go-mode
      js2-mode
      nginx-mode
      php-mode
      rust-mode
      sql-mode
      toml-mode
      web-mode
      yaml-mode
      {{end}}
      ))

  ;; インストールされていないパッケージのリストを作成
  (let ((not-installed '()))
    (dolist (pkg installing-package-list)
      (unless (package-installed-p pkg)
        (setq not-installed (cons pkg not-installed))))
    
    ;; インストールされていないパッケージがあればインストール
    (when not-installed
      (package-refresh-contents)
      (dolist (pkg (reverse not-installed))
        (condition-case nil
            (package-install pkg)
          (error nil))))))

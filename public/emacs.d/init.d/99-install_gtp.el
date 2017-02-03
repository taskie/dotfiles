(defun my-install ()
  (interactive)
  (require 'cl-lib)

  (defvar installing-package-list
    '(
      cl-lib
      popup

      anzu
      company
      git-gutter+
      helm
      magit
      popwin
      recentf-ext
      sequential-command
      undo-tree
      volatile-highlights

      markdown-mode

      {{if .allplugins}}
      elscreen
      evil
      foreign-regexp
      migemo
      tabbar
      ;; yasnippet

      ;; helm-c-yasnippet
      helm-descbinds
      helm-migemo
      helm-ls-git

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

      solarized-theme
      {{end}}

      {{if .mac}}
      osx-pseudo-daemon
      {{end}}
      ))

  (let ((not-installed (cl-loop for x in installing-package-list
                                when (not (package-installed-p x))
                                collect x)))
    (when not-installed
      (package-refresh-contents)
      (cl-dolist (pkg not-installed)
        (ignore-errors (package-install pkg))))))

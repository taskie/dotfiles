(defun my-install ()
  (interactive)
  (require 'cl-lib)

  (defvar installing-package-list
    '(
      cl-lib
      popup

      anzu
      company
      ;; elscreen
      evil
      foreign-regexp
      git-gutter+
      ;; git-gutter-fringe+
      helm
      ;; init-loader
      magit
      ;; migemo
      popwin
      recentf-ext
      sequential-command
      tabbar
      undo-tree
      volatile-highlights
      ;; yasnippet

      ;; helm-c-yasnippet
      helm-ls-git
      helm-migemo
      helm-descbinds

      flycheck

      js2-mode
      go-mode
      rust-mode
      markdown-mode
      nginx-mode
      php-mode
      ;; sql-mode
      web-mode
      yaml-mode

      ;; solarized-theme

      ;; osx-pseudo-daemon
      ))

  (let ((not-installed (cl-loop for x in installing-package-list
                                when (not (package-installed-p x))
                                collect x)))
    (when not-installed
      (package-refresh-contents)
      (cl-dolist (pkg not-installed)
        (ignore-errors (package-install pkg))))))

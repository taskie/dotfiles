(unless (require 'package nil t)
  (message "use core/package/package.el")
  (add-to-list 'load-path "{{.dotfiles}}/private/core/package")
  (require 'package))

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (require 'package nil t)
  (message "use core/package/package.el")
  (add-to-list 'load-path "{{.dotfiles}}/private/core/package")
  (require 'package))

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

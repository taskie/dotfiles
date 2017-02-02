(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

(icomplete-mode 1)

(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)

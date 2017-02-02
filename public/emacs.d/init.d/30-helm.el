(when (require 'helm-config nil t)
  (helm-mode 1)

  ;; http://d.hatena.ne.jp/a_bicky/20140104/1388822688
  ;; http://d.hatena.ne.jp/syohex/20121224/1356330903

  (global-set-key (kbd "C-M-z") 'helm-resume)
  (global-set-key (kbd "C-x C-r") 'helm-recentf)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
  (global-set-key (kbd "C-M-s") 'helm-occur)
  (global-set-key (kbd "C-x C-i") 'helm-imenu)

  ;; Emulate `kill-line' in helm minibuffer
  (setq helm-delete-minibuffer-contents-from-point t)
  (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
    "Emulate `kill-line' in helm minibuffer"
    (kill-new (buffer-substring (point) (field-end)))))

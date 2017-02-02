;;; キーバインド
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-unset-key (kbd "C-t"))
(global-unset-key (kbd "C-z"))

;;; http://d.hatena.ne.jp/kiwanami/20121216/1355706256
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))

(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)

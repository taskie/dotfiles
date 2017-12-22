;;; http://ama-ch.hatenablog.com/entry/20090114/1231918903

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(global-set-key (kbd "M-k") 'backward-kill-line)

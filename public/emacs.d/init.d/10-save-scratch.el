;;; scratchバッファの自動保存と復元

;; *scratch* バッファの内容をファイルに保存する
(defun save-scratch-data ()
  (let ((str (progn
	       (set-buffer (get-buffer "*scratch*"))
	       (buffer-substring-no-properties
		(point-min) (point-max))))
	(file "~/.emacs.d/scratch"))
    (if (get-file-buffer (expand-file-name file))
	(setq buf (get-file-buffer (expand-file-name file)))
      (setq buf (find-file-noselect file)))
    (set-buffer buf)
    (erase-buffer)
    (insert str)
    (save-buffer)
    (kill-buffer buf)))

;; Emacs 終了時に *scratch* バッファを自動保存
(define-advice save-buffers-kill-emacs
    (:before (&rest _args) save-scratch-buffer)
  (save-scratch-data))

;; 前回保存した *scratch* バッファの内容を復元する
(defun read-scratch-data ()
  (let ((file "~/.emacs.d/scratch"))
    (when (file-exists-p file)
      (set-buffer (get-buffer "*scratch*"))
      (erase-buffer)
      (insert-file-contents file))
    ))

;; Emacs 起動時に *scratch* バッファの内容を復元
(read-scratch-data)

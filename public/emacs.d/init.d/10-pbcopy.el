(defun pbcopy (beg end)
  "Send the selected region to pbcopy."
  (interactive "r")
  (if (use-region-p)
      (let ((process-connection-type nil)
            (text (buffer-substring-no-properties beg end)))
        ;; 非同期プロセスでpbcopyを呼び出し、テキストを流し込む
        (let ((proc (start-process "pbcopy" nil "pbcopy")))
          (process-send-string proc text)
          (process-send-eof proc)
          (message "Copied to clipboard (pbcopy)")))
    (message "No text selected")))

(defun pbpaste ()
  "Insert pbpaste content at point (replaces region if active)."
  (interactive)
  (let ((clipboard-text (shell-command-to-string "pbpaste")))
    ;; 選択範囲(リージョン)がアクティブな場合は、その範囲を削除する
    (when (use-region-p)
      (delete-region (region-beginning) (region-end)))
    ;; テキストを挿入する
    (insert clipboard-text)
    (message "Pasted from clipboard (pbpaste)")))

(global-set-key (kbd "C-c c") 'pbcopy)
(global-set-key (kbd "C-c v") 'pbpaste)

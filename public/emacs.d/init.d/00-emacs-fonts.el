(defun aps-set-font ()
  (interactive)
  (let* ((font-name "Migu 1M")) ; (let* ((font-name "PixelMplus12"))
    (set-frame-font font-name)
    (set-face-attribute 'default nil :family font-name :height 120)
    (set-fontset-font (frame-parameter nil 'font)
		      'japanese-jisx0208
		      `(,font-name . "iso10646-1"))
    (set-fontset-font (frame-parameter nil 'font)
		      'japanese-jisx0212
		      `(,font-name . "iso10646-1"))
    (set-fontset-font (frame-parameter nil 'font)
		      'mule-unicode-0100-24ff
		      `(,font-name . "iso10646-1"))
    (set-fontset-font (frame-parameter nil 'font)
		      'katakana-jisx0201
		      `(,font-name . "iso10646-1"))
    (setq mac-allow-anti-aliasing t)
    (setq-default line-spacing 0)))

(when window-system (aps-set-font))

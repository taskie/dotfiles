;;; テーマ（背景なし）
(custom-set-faces
 '(default ((t (:background "unspecified-bg" :foreground nil))))
 '(highlight ((t (:background "#222" :foreground nil))))
 '(show-paren-match ((t (:background "#666" :foreground nil)))))

(when (fboundp 'load-theme)
  (load-theme 'misterioso t))

;;; 行列番号表示
(line-number-mode 1)
(column-number-mode 1)

;;; 行強調表示
(global-hl-line-mode 1)

;;; 対括弧強調表示
(show-paren-mode t)
(setq show-paren-delay 0)

;;; 行番号表示
; (global-linum-mode t)
(setq linum-format "%4d ")

;;; 起動画面
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

(defun aps-solarized ()
  (interactive)
  (setq solarized-distinct-fringe-background t)
  (setq solarized-high-contrast-mode-line t)
  (load-theme 'solarized-light t))

(defun aps-solarized-dark ()
  (interactive)
  (setq solarized-distinct-fringe-background t)
  (setq solarized-high-contrast-mode-line t)
  (load-theme 'solarized-dark t))

;;; メニューバー等非表示
(unless window-system
  (menu-bar-mode -1))
(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;;; 日付・時刻表示
;;; （全角文字が右端に来ないよう英語表記で）
(setq display-time-string-forms
      '((format "%s/%s/%s(%s) %s:%s" year month day dayname 24-hours minutes)
        load
        (if mail " Mail" "")))
(display-time)

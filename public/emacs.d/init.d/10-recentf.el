;;; recentf - 最近使ったファイル
;;; http://d.hatena.ne.jp/tomoya/20110217/1297928222
(require 'recentf)
(setq recentf-max-saved-items 2000)
(setq recentf-exclude '(".recentf"))
(setq recentf-auto-cleanup 10)
(setq recentf-auto-save-timer
      (run-with-idle-timer 300 t 'recentf-save-list))
(recentf-mode 1)

(savehist-mode 1)
(setq history-length 3000)

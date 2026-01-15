;;; 基本キーバインディング設定

;; C-h をバックスペース（後方削除）に変更（デフォルトの C-h はヘルプ）
(global-set-key (kbd "C-h") 'delete-backward-char)

;; C-t（文字入れ替え）を無効化
(global-unset-key (kbd "C-t"))

;; C-z（サスペンド）を無効化
(global-unset-key (kbd "C-z"))

;; 手元の init.el を淡々と紹介する - 技術日記＠kiwanami
;; https://kiwanami.hatenadiary.org/entry/20121216/1355706256
;; リージョンが有効なら切り取り、無効なら後方の単語を削除する
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))

(global-set-key (kbd "C-w") 'kill-region-or-backward-kill-word)

;; Emacsでカーソル位置から行頭まで削除する方法 - はてブロ@ama_ch
;; https://ama-ch.hatenablog.com/entry/20090114/1231918903
;; デフォルトの C-u（ユニバーサル引数）は M-数字 や C-数字 で代替可能
(defun backward-kill-line (arg)
  (interactive "p")
  (kill-line (- 1 arg)))

(global-set-key (kbd "C-u") 'backward-kill-line)

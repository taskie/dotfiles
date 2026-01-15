;;; swiper - Ivyを使用したインクリメンタル検索ツール

(use-package swiper
  :ensure nil
  :if (package-installed-p 'swiper)
  :config
  ;; M-s M-s: カーソル位置の単語（thing-at-point）を swiper で検索
  (global-set-key (kbd "M-s M-s") 'swiper-thing-at-point))

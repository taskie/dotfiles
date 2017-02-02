;; http://yohshiy.blog.fc2.com/blog-entry-264.html
;; http://seesaawiki.jp/whiteflare503/d/Emacs%20%A5%A4%A5%F3%A5%C7%A5%F3%A5%C8
;; http://d.hatena.ne.jp/i_s/20091026/1256557730

(defun my-c-c++-mode-init ()
  (c-set-style "ellemtel")
  (c-toggle-hungry-state 1)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
  (show-paren-mode t))

(add-hook 'c-mode-common-hook 'my-c-c++-mode-init)

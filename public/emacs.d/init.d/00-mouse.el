;;; マウス設定

(unless (display-graphic-p)
  ;; マウスサポートを有効化
  (xterm-mouse-mode 1)
  (mouse-wheel-mode 1)
  
  ;; ホイールをバインド
  (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
  (global-set-key (kbd "<mouse-5>") 'scroll-up-line)
  
  ;; スムーズスクロール設定
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
  (setq mouse-wheel-progressive-speed nil)
  (setq mouse-wheel-follow-mouse t))

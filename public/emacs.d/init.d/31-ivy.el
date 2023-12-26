;;; helm を背に ivy の門を叩く #Emacs - Qiita
;;; https://qiita.com/takaxp/items/2fde2c119e419713342b
(when (require 'ivy nil t)
  (require 'ivy-hydra nil t)

  ;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める．
  (setq ivy-use-virtual-buffers t)
  ;; ミニバッファでコマンド発行を認める
  (when (setq enable-recursive-minibuffers t)
    (minibuffer-depth-indicate-mode 1)) ;; 何回層入ったかプロンプトに表示．
  ;; ESC連打でミニバッファを閉じる
  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  (ivy-mode 1))

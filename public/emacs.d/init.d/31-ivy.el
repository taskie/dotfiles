;;; ivy - 軽量高速な補完フレームワーク

;;; 参考: helm を背に ivy の門を叩く #Emacs - Qiita
;;; https://qiita.com/takaxp/items/2fde2c119e419713342b
(use-package ivy
  :ensure nil
  :if (package-installed-p 'ivy)
  :diminish ivy-mode
  :config
  ;; ivy-hydra: Ivy の操作中にヘルプメニューを表示する機能
  (require 'ivy-hydra nil t)

  ;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める
  (setq ivy-use-virtual-buffers t)
  
  ;; ミニバッファでコマンド発行を認める（再帰的ミニバッファ）
  (when (setq enable-recursive-minibuffers t)
    ;; 何回層入ったかプロンプトに数字で表示
    (minibuffer-depth-indicate-mode 1))
  
  ;; ESC 連打でミニバッファを閉じる
  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  ;; ivy-mode を全体で有効化
  (ivy-mode 1))

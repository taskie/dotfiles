;;; ミニバッファ設定

;; *Messages* バッファに保存するメッセージの最大数を設定
(setq message-log-max 10000)

;; ミニバッファ履歴の保存数を設定
(setq history-length 1000)

;; キー入力をミニバッファに表示するまでの遅延時間（秒）
(setq echo-keystrokes 0.1)

;; ミニバッファ内でさらにミニバッファを使用する再帰呼び出しを許可
(setq enable-recursive-minibuffers t)

;; 再帰編集中断時の挙動を変更（ミニバッファの内容を履歴に保存）
(define-advice abort-recursive-edit 
    (:before (&rest _args) minibuffer-save)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))

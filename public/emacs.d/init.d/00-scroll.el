;;; スクロール動作の設定

;; scroll-conservatively: カーソルが画面外に出そうな時のスクロール量を制御
;;   35以上に設定すると、カーソルを中央に戻す「ジャンプ」が発生せず、
;;   1行ずつ滑らかにスクロールする。デフォルトは 0（ジャンプする）
;; scroll-margin: 画面上下端からカーソルまでの最小行数（余白）
;;   0 に設定すると、カーソルが画面端まで移動できる
;; scroll-step: scroll-conservatively が無効の場合のスクロール行数
;;   1 に設定すると、画面外に出る際に1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

;; comint モード（シェル、REPL など）で出力時に自動的に最下部までスクロール
(setq comint-scroll-show-maximum-output t)

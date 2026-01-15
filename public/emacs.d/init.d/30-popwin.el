;;; popwin - 一時的なバッファを専用のポップアップウィンドウで表示

(use-package popwin
  :ensure nil
  :if (package-installed-p 'popwin)
  :config
  ;; すべてのバッファ表示に popwin を使用
  (setq display-buffer-function 'popwin:display-buffer)

  ;; 大きな画面では横分割、小さな画面では縦分割にする
  (defun popwin-auto-set-popup-window-position ()
    (interactive)
    (let ((w (frame-width))
          (h (frame-height)))
      (setq popwin:popup-window-position
            (if (and (< 200 w)
                     (< h w))
                'right
              'bottom))))
  
  ;; popwin 表示時にフレームサイズに応じた表示位置を自動設定
  (define-advice popwin:display-buffer 
      (:before (&rest _args) popwin-auto-window-position)
    (popwin-auto-set-popup-window-position)))

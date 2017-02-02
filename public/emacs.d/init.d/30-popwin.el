(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer)
  ;; フレームのサイズに応じてpopwinの出現位置を決める
  (defun popwin-auto-set-popup-window-position ()
    (interactive)
    (let ((w (frame-width))
          (h (frame-height)))
      (setq popwin:popup-window-position
            (if (and (< 200 w)         ; フレームの幅が200桁より大きくて
                     (< h w))          ; 横長の時に
                'right                 ; 右へ出す
              'bottom))))              ; そうじゃないときは下へ出す
  ;; popwin表示時にフレームサイズに応じた表示位置にする
  (defadvice popwin:display-buffer (before popwin-auto-window-position activate)
    (popwin-auto-set-popup-window-position)))

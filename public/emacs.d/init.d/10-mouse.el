;;; マウス対応

(unless (fboundp 'track-mouse)
  (defun trackmouse (e)))
(xterm-mouse-mode t)
(require 'mouse)
(require 'mwheel)
(mouse-wheel-mode t)
(global-set-key [mouse-4] (lambda ()
                            (interactive)
                            (scroll-down 1)))
(global-set-key [mouse-5] (lambda ()
                            (interactive)
                            (scroll-up 1)))

;;; http://www.emacswiki.org/emacs/SmoothScrolling

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse t) ;; scroll window under mouse

;;; http://stackoverflow.com/questions/6462167/emacsclient-does-not-respond-to-mouse-clicks

(defun my-terminal-config (&optional frame)
  "Establish settings for the current terminal."
  (if (not frame) ;; The initial call.
      (xterm-mouse-mode 1)
    ;; Otherwise called via after-make-frame-functions.
    (if xterm-mouse-mode
        ;; Re-initialise the mode in case of a new terminal.
        (xterm-mouse-mode 1))))
;; Evaluate both now (for non-daemon emacs) and upon frame creation
;; (for new terminals via emacsclient).
(my-terminal-config)
(add-hook 'after-make-frame-functions 'my-terminal-config)

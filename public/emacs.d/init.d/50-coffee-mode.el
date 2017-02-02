(defun coffee-custom ()
  "coffee-mode-hook"
  (and (set (make-local-variable 'tab-width) 4)
       (set (make-local-variable 'coffee-tab-width) 4)))

(add-hook 'coffee-mode-hook
	    '(lambda() (coffee-custom)))

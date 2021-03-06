;;; http://cloverrose.hateblo.jp/entry/2013/04/15/183839
;;; http://d.hatena.ne.jp/plasticster/20110825/1314271209

(when (require 'tabbar nil t)
  (defun aps-tabbar ()
    (interactive)
    (tabbar-mwheel-mode -1)
    (setq tabbar-buffer-groups-function nil)
    (tabbar-mode)
    (setq tabbar-separator '(1.0))
    (set-face-attribute
     'tabbar-default nil
     :family (face-attribute 'default :family)
     :background (face-attribute 'mode-line-inactive :background)
     :height 1.0)
    (set-face-attribute
     'tabbar-unselected nil
     :background (face-attribute 'mode-line-inactive :background)
     :foreground (face-attribute 'mode-line-inactive :foreground))
    (set-face-attribute
     'tabbar-selected nil
     :weight 'bold
     :background (face-attribute 'mode-line :background)
     :foreground (face-attribute 'mode-line :foreground))
    (set-face-attribute
     'tabbar-modified nil
     :weight 'bold
     :background (face-attribute 'mode-line-inactive :background)
     :foreground (face-attribute 'mode-line-inactive :foreground))
    (global-set-key (kbd "M-[") 'tabbar-backward)
    (global-set-key (kbd "M-]") 'tabbar-forward)
    (dolist (btn '(tabbar-buffer-home-button
                   tabbar-scroll-left-button
                   tabbar-scroll-right-button))
      (set btn (cons (cons "" nil)
                     (cons "" nil))))

    (defvar my-tabbar-displayed-buffers
      '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-")
      "*Regexps matches buffer names always included tabs.")

    (defvar my-tabbar-protected-buffers
      '("*scratch*" "*Messages*"))

    (defun my-tabbar-buffer-list ()
      "Return the list of buffers to show in tabs.
Exclude buffers whose name starts with a space or an asterisk.
The current buffer and buffers matches `my-tabbar-displayed-buffers'
are always included."
      (let* ((hides (list ?\  ?\*))
             (re (regexp-opt my-tabbar-displayed-buffers))
             (cur-buf (current-buffer))
             (tabs (delq nil
                         (mapcar (lambda (buf)
                                   (let ((name (buffer-name buf)))
                                     (when (or (string-match re name)
                                               (not (memq (aref name 0) hides)))
                                       buf)))
                                 (buffer-list)))))
        ;; Always include the current buffer.
        (if (memq cur-buf tabs)
            tabs
          (cons cur-buf tabs))))

    (defun my-tabbar-buffer-help-on-tab (tab)
      "Return the help string shown when mouse is onto TAB."
      (if tabbar--buffer-show-groups
          (let* ((tabset (tabbar-tab-tabset tab))
                 (tab (tabbar-selected-tab tabset)))
            (format "mouse-1: switch to buffer %S in group [%s]"
                    (buffer-name (tabbar-tab-value tab)) tabset))
        (format "\
mouse-1: switch to buffer %S\n\
mouse-2: delete other windows\n\
mouse-3: kill this buffer"
                (buffer-name (tabbar-tab-value tab)))))

    (defun my-tabbar-buffer-select-tab (event tab)
      "On mouse EVENT, select TAB."
      (let ((mouse-button (event-basic-type event))
            (buffer (tabbar-tab-value tab)))
        (cond
         ((eq mouse-button 'mouse-2)
          (delete-other-windows))
         ((eq mouse-button 'mouse-3)
          (with-current-buffer buffer
            (unless (string-equal (buffer-name) "*scratch*")
              (kill-buffer))))
         (t
          (switch-to-buffer buffer)))
        ;; Don't show groups.
        (tabbar-buffer-show-groups nil)))

    (setq tabbar-help-on-tab-function 'my-tabbar-buffer-help-on-tab)
    (setq tabbar-select-tab-function 'my-tabbar-buffer-select-tab)
    (setq tabbar-buffer-list-function 'my-tabbar-buffer-list))

  (when window-system (aps-tabbar)))

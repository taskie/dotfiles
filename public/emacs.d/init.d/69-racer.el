(setq racer-rust-src-path "~/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src")
(setq racer-cmd "~/.cargo/bin/racer")
(eval-after-load "rust-mode" '(require 'racer nil t))

(add-hook 'rust-mode-hook
          '(lambda ()
             (racer-activate)
             (local-set-key (kbd "M-.") #'racer-find-definition)
             (local-set-key (kbd "TAB") #'racer-complete-or-indent)))

(when (require 'company-racer nil t)
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-racer)))

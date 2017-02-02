(when (require 'sequential-command-config nil t)
  (sequential-command-setup-keys)

  (define-sequential-command seq-home
    back-to-indentation beginning-of-line beginning-of-buffer seq-return)
  (global-set-key "\C-a" 'seq-home)
  (define-sequential-command seq-end
    end-of-line end-of-buffer seq-return)
  (global-set-key "\C-e" 'seq-end))

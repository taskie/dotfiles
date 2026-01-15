;;; sequential-command - 連続キー入力で段階的に動作を変える

(use-package sequential-command
  :ensure nil
  :if (package-installed-p 'sequential-command)
  :config
  ;; 標準的な sequential-command の動作を有効化
  (require 'sequential-command-config)
  (sequential-command-setup-keys)

  ;; C-a の連続実行時の動作を定義
  ;; 1回目: back-to-indentation（インデントを除く行頭へ移動）
  ;; 2回目: beginning-of-line（真の行頭へ移動）
  ;; 3回目: beginning-of-buffer（バッファの先頭へ移動）
  ;; 4回目: seq-return（元の位置に戻る）
  (define-sequential-command seq-home
    back-to-indentation beginning-of-line beginning-of-buffer seq-return)
  (global-set-key "\C-a" 'seq-home)
  
  ;; C-e の連続実行時の動作を定義
  ;; 1回目: end-of-line（行末へ移動）
  ;; 2回目: end-of-buffer（バッファの末尾へ移動）
  ;; 3回目: seq-return（元の位置に戻る）
  (define-sequential-command seq-end
    end-of-line end-of-buffer seq-return)
  (global-set-key "\C-e" 'seq-end))

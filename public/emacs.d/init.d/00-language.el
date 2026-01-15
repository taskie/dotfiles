;;; 言語・エンコーディング設定

;; 言語環境を日本語に設定
(set-language-environment 'Japanese)

;; すべての新規バッファのデフォルト文字コードを UTF-8 に設定
(set-default-coding-systems 'utf-8)

;; キーボード入力の文字コードを UTF-8 に設定
(set-keyboard-coding-system 'utf-8)

;; 端末（ターミナル）との入出力に使用する文字コードを UTF-8 に設定
(set-terminal-coding-system 'utf-8)

;; ファイル保存時のデフォルト文字コードを UTF-8 に設定
(set-buffer-file-coding-system 'utf-8)

;; ファイルを開く際の文字コード自動判定で UTF-8 を最優先に設定
(prefer-coding-system 'utf-8)

;; East Asian Ambiguous Width 文字を半角幅として扱う
(setq east-asian-ambiguous-width 1)

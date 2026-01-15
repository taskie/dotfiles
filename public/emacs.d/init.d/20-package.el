;;; パッケージ管理設定

;; package.el をロード
(require 'package)

;; パッケージリポジトリの設定
(setq package-archives
  '(("melpa" . "https://melpa.org/packages/")
    ("gnu" . "https://elpa.gnu.org/packages/")
    ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; パッケージシステムを初期化
(package-initialize)

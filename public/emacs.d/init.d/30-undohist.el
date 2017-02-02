(when (version-list-< (version-to-list emacs-version) '(24 3))
  (require 'undohist)
  (undohist-initialize))

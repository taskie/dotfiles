(when (require 'git-gutter+ nil t)

  (defadvice git-gutter+-process-diff
      (before git-gutter+-process-diff-advice activate)
    (ad-set-arg 0 (file-truename (ad-get-arg 0))))

  ;; (global-git-gutter+-mode)
  )

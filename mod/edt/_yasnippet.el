;;; _yasnippet.el --- fgh
;;; Commentary:
;; 
;;; Code:
(unless (package-installed-p 'yasnippet)
  (package-install 'yasnippet))
(use-package yasnippet
  :ensure t)
(provide '_yasnippet)
;;; _yasnippet.el ends here

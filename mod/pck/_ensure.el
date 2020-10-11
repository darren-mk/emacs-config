;;; _ensure.el --- custom tools
;;; Commentary:
;;; Code:
(defun ensure-installed-and-require (package)
  "Custom function to ensure a PACKAGE is installed and to require it."
  (unless (package-installed-p package)
    (package-install package))
  (require package))
(defun ensure-installed (package)
  "Custom function to ensure a PACKAGE is installed."
  (unless (package-installed-p package)
    (package-install package)))
(provide '_ensure)
;;; _ensure.el ends here

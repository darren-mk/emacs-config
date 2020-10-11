;;; _use-package.el --- enable use-pacakge
;;; Commentary:
;;; Code:
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(provide '_use-package)
;;; _use-package.el ends here

;;; _rps.el --- Configure repositories.
;;; Commentary:
;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-refresh-contents)
(package-initialize)
(provide '_rps)
;;; _rps.el ends here

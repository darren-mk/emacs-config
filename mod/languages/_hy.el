;;; -*- lexical-binding: t; -*-

;;; _hy.el --- Config for Hylang
;;; Commentary:
;;; Code:

;;; hy-mode
(ensure-installed-and-require 'hy-mode)
(hy-jedhy-update-imports)
(company-hy 1)

(provide '_hy)
;;; _hy.el ends here

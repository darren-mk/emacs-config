;;; -*- lexical-binding: t; -*-

;;; _yaml.el --- config for yaml
;;; Commentary:
;;; Code:
(ensure-installed-and-require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(provide '_yaml)
;;; _yaml.el ends here

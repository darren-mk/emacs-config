;;; _fnt.el --- Config for Fonts and Their Sizes
;;; Commentary:
;;; Code:
;;(defvar desired-font-and-size "Source Code Pro-9")
(add-to-list 'default-frame-alist '(font . "Source Code Pro-13"))
(set-face-attribute 'default t :font "Source Code Pro-13")
;; increase font size for better readability
;; (set-face-attribute 'default nil :height 110)
(provide '_font)
;;; _font.el ends here

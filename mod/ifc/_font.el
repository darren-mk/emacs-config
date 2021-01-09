;;; _fnt.el --- Config for Fonts and Their Sizes
;;; Commentary:
;;; Code:
;;(defvar desired-font-and-size "Source Code Pro-9")
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-15"))
(set-face-attribute 'default t :font "DejaVu Sans Mono-15")
;; increase font size for better readability
;; (set-face-attribute 'default nil :height 110)
(provide '_font)
;;; _font.el ends here

;;; -*- lexical-binding: t; -*-

;; set path to racket program
(defvar racket-program "/opt/homebrew/bin/racket")

;; ensure racket modoe for enacs
(ensure-installed-and-require 'racket-mode)

;; attach paredit
(add-hook 'racket-mode-hook
	        #'enable-paredit-mode)

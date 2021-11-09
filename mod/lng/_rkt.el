;; set path to racket program
(defvar racket-racket-program "/usr/bin/racket")
(defvar racket-raco-program "/usr/bin/raco")

;; ensure racket modoe for enacs
(ensure-installed-and-require 'racket-mode)

;; attach paredit
(add-hook 'racket-mode-hook
	  #'enable-paredit-mode)

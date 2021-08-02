;; slime 
(ensure-installed-and-require 'slime)
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; sly
;;(ensure-installed-and-require 'sly)
;; implementation 
(setq inferior-lisp-program "/usr/bin/sbcl")

;; paredit
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

;; https://lisp-lang.org/learn/getting-started/
;; (load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/opt/homebrew/bin/sbcl")
;; sly
(ensure-installed-and-require 'sly)
;; paredit
(add-hook 'lisp-mode-hook
	  #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook
	  #'enable-paredit-mode)

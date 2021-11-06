;; https://lisp-lang.org/learn/getting-started/
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/opt/homebrew/bin/sbcl")
;;
(add-hook 'lisp-mode-hook
	  #'enable-paredit-mode)
;; 
(add-hook 'slime-repl-mode-hook
	  (lambda () (paredit-mode +1)))

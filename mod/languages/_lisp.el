;; https://lisp-lang.org/learn/getting-started/
;; load slime-helper
;;(load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; path for sbcl
(setq inferior-lisp-program
      (case system-type
	('gnu/linux "/usr/bin/sbcl")
	('darwin "/opt/homebrew/bin/sbcl")))
;; slime/sly
(ensure-installed-and-require 'sly)
;; paredit
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'sly-repl-mode-hook (lambda () (paredit-mode +1)))

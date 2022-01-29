;; https://lisp-lang.org/learn/getting-started/
;; load slime-helper
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; path for sbcl
(setq inferior-lisp-program
      (case system-type
	('gnu/linux "/usr/bin/sbcl")
	('darwin "/opt/homebrew/bin/sbcl")))
;; slime
(ensure-installed-and-require 'slime)
;; paredit
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

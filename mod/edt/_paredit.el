(ensure-installed-and-require 'paredit)

;; https://www.emacswiki.org/emacs/ParEdit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

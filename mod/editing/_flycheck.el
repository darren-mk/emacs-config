;; install flycheck
(ensure-installed-and-require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(global-flycheck-mode)

;; block flycheck for below modes
(setq flycheck-global-modes '(not emacs-lisp-mode))

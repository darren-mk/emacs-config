;;; -*- lexical-binding: t; -*-

(use-package exec-path-from-shell)
(when (daemonp)
  (exec-path-from-shell-initialize))
(use-package haskell-mode
  :defer t
  :ensure t
  :bind (:map haskell-mode-map
              (("C-c C-c" . haskell-compile))))
(add-hook 'haskell-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'flymake-mode)
(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-type 'cabal-repl))

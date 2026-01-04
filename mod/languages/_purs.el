;;; -*- lexical-binding: t; -*-

;; mac:
;; brew install spago
;; brew install purescript
;; brew install purescript-language-server

(use-package purescript-mode)
(add-hook 'purescript-mode-hook 'eglot-ensure)
(with-eval-after-load 'eglot
  (add-to-list
   'eglot-server-programs
   '(purescript-mode
     . ("purescript-language-server" "--stdio"))))
(add-hook 'purescript-mode-hook 'flymake-mode)

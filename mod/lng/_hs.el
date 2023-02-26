(ensure-installed-and-require 'haskell-mode)
;; https://github.com/emacs-lsp/lsp-haskell
(ensure-installed-and-require 'lsp-haskell)


(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(add-hook 'haskell-literate-mode-hook #'lsp)

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t)
  '(haskell-process-type 'cabal-repl)) ;; Configure haskell-mode to use sandboxes

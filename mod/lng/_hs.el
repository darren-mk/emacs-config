(ensure-installed-and-require 'haskell-mode)
;; https://github.com/emacs-lsp/lsp-haskell
(ensure-installed-and-require 'lsp-haskell)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
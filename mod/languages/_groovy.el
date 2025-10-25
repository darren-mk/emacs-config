(ensure-installed-and-require 'groovy-mode)

(add-hook 'groovy-mode-hook #'lsp-deferred)

(ensure-installed-and-require 'lsp-mode)
(ensure-installed-and-require 'lsp-ui)

;; with company
(ensure-installed-and-require 'company-lsp)
(push 'company-lsp company-backends)

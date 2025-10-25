(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright")
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))

;; in your init.el
(use-package pytest
  :ensure t
  :bind (("C-c t t" . pytest-one)
         ("C-c t f" . pytest-file)
         ("C-c t p" . pytest))
  :config (setq pytest-cmd-flags "-q"))

(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright")
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))

(use-package pytest
  :ensure t)

(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key "\C-c a" 'pytest-all)
            (local-set-key "\C-c m" 'pytest-module)
            (local-set-key "\C-c ." 'pytest-one)
            (local-set-key "\C-c c" 'pytest-again)
            (local-set-key "\C-c d" 'pytest-directory)))

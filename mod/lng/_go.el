(use-package go-mode
  :defer t
  :ensure t)

(add-hook 'go-mode-hook #'lsp-deferred)

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(defun my-go-mode-lsp-disable-formatting ()
  (setq-local lsp-enable-on-type-formatting nil)
  (setq-local lsp-enable-indentation nil)
  (remove-hook 'before-save-hook #'lsp-format-buffer t))

(add-hook 'go-mode-hook #'my-go-mode-lsp-disable-formatting)

(use-package gotest
  :defer t
  :ensure t)

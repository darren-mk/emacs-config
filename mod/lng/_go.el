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
  :ensure t
  :commands (go-test-current-file go-test-current-test
             go-test-current-project go-test-current-benchmark)
  :init
  (with-eval-after-load 'go-mode
    (define-key go-mode-map (kbd "C-c t f") #'go-test-current-file)
    (define-key go-mode-map (kbd "C-c t t") #'go-test-current-test)
    (define-key go-mode-map (kbd "C-c t p") #'go-test-current-project)
    (define-key go-mode-map (kbd "C-c t b") #'go-test-current-benchmark)))

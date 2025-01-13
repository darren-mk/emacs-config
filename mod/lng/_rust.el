;; installation on mac
;; $ brew install rustup
;; $ rustup-init
;; $ rustup component add rust-analyzer

(use-package rust-mode
  :defer t :ensure t)

(add-hook 'rust-mode-hook #'lsp)

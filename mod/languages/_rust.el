;; installation on fedora
;; $ sudo dnf install rustc
;; $ sudo dnf install cargo
;; $ sudo dnf install clippy

;; installation on mac
;; $ brew install rustup
;; $ rustup-init
;; $ rustup component add rust-analyzer

(use-package rustic
  :ensure t
  :config
  (setq rustic-format-on-save nil)
  :custom
  (rustic-cargo-use-last-stored-arguments t))

;;; -*- lexical-binding: t; -*-

;; fedora:
;; $ sudo dnf install rustc cargo clippy

;; mac:
;; $ brew install rustup
;; $ rustup-init
;; $ rustup component add rust-analyzer

(use-package rustic
  :ensure t
  :config
  (setq rustic-format-on-save nil)
  :custom
  (rustic-cargo-use-last-stored-arguments t))

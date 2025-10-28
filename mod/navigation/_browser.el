;;;; prerequisite
;;; fedora
;; $ sudo dnf install w3m w3m-img

(use-package w3m
  :ensure t
  :config
  (setq w3m-use-cookies t))

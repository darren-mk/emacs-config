;;; -*- lexical-binding: t; -*-

(use-package paredit
  :ensure t
  :commands enable-paredit-mode
  :hook ((emacs-lisp-mode
          clojure-mode
          clojurescript-mode
          lisp-mode
          scheme-mode)
         . enable-paredit-mode))

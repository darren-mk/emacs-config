;;; -*- lexical-binding: t; -*-

(use-package aidermacs
  :ensure t
  :bind (("C-c a" . aidermacs-transient-menu))
  :config
  (setq aidermacs-default-model "gemini/gemini-2.0-flash")
  (setq aidermacs-backend 'vterm))

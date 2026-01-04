;;; -*- lexical-binding: t; -*-

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-copy-env "GOOGLE_API_KEY")
  (exec-path-from-shell-copy-env "GEMINI_API_KEY")
  (exec-path-from-shell-initialize))

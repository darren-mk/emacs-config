;; https://github.com/bradyt/dart-mode
(ensure-installed-and-require 'dart-mode)

;; https://github.com/emacs-lsp/lsp-dart
(setq package-selected-packages
  '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company
    ;; Optional packages
    lsp-ui company hover))
(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))
(add-hook 'dart-mode-hook 'lsp)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

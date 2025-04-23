;; prerequisites:
;; $ brew install --cask dotnet-sdk
;; eglot in emacs

;; reference:
;; https://arialdomartini.github.io/emacs-fsharp

(use-package fsharp-mode
  :defer t
  :ensure t
  :config (add-hook 'fsharp-mode-hook
                    'highlight-indentation-mode))

(use-package eglot-fsharp
  :ensure t
  :after fsharp-mode
  :config (add-hook 'fsharp-mode-hook
                    #'eglot-ensure))

(use-package corfu
  :ensure t
  :init (global-corfu-mode)
  :config (setq corfu-min-width 250
                corfu-min-height 750
                corfu-count 20
                corfu-auto t
                corfu-cycle t
                corfu-separator ?\s
                corfu-preview-current "insert"
                corfu-scroll-margin 25
                ;; enable corfu on TAB
                tab-always-indent 'complete
                ;; shows documentation after `corfu-popupinfo-delay'
                corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1)
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config (nerd-icons-completion-marginalia-setup)
  (nerd-icons-completion-mode 1))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config (add-to-list 'corfu-margin-formatters
                       #'nerd-icons-corfu-formatter))

(setq-default fsharp-indent-offset 4)

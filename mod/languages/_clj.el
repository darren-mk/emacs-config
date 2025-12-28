;; brew install --cask temurin@21
;; brew install clojure/tools/clojure
;; brew install clojure-lsp

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package clojure-mode
  :ensure t
  :mode (("\\.edn\\'"   . clojure-mode)
         ("\\.clj\\'"   . clojure-mode)
         ("\\.cljc\\'"  . clojurec-mode)
         ("\\.cljs\\'"  . clojurescript-mode)
         ("lein-env"    . enh-ruby-mode))
  :hook ((clojure-mode . paredit-mode)
         (clojurescript-mode . paredit-mode)
         (clojurec-mode . paredit-mode)
         (clojure-mode . my-clj-format-on-save)
         (clojurescript-mode . my-clj-format-on-save)
         (clojurec-mode . my-clj-format-on-save))
  :init
  (defun my-clj-format-on-save ()
    (add-hook 'before-save-hook #'cider-format-buffer nil t)))

(use-package cider
  :ensure t
  :after clojure-mode
  :hook ((clojure-mode . cider-mode)
         (cider-repl-mode . paredit-mode))
  :custom
  (cider-save-file-on-load t)
  (cider-repl-display-help-banner nil))

(with-eval-after-load 'lsp-mode
  (add-hook 'clojure-mode-hook #'lsp-deferred)
  (add-hook 'clojurescript-mode-hook #'lsp-deferred)
  (add-hook 'clojurec-mode-hook #'lsp-deferred))

(with-eval-after-load 'company
  (add-hook 'clojure-mode-hook #'company-mode)
  (add-hook 'cider-repl-mode-hook #'company-mode))

(use-package flycheck-clj-kondo
  :ensure t
  :after (clojure-mode flycheck))



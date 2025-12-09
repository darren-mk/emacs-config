;; install jdk
;; https://clojure.org/guides/install_clojure#java
;; brew install --cask temurin@21

;; install clojure cli
;; https://clojure.org/guides/install_clojure
;; brew install clojure/tools/clojure

;; install clojure-lsp
;; https://formulae.brew.sh/formula/clojure-lsp
;; brew install clojure-lsp

;; mac PATH fix
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; paredit
(use-package paredit
  :ensure t)

;; clojure modes
(use-package clojure-mode
  :ensure t
  :mode (("\\.edn\\'"  . clojure-mode)
         ("\\.clj\\'"  . clojure-mode)
         ("\\.cljc\\'" . clojurec-mode)
         ("\\.cljs\\'" . clojurescript-mode)
         ("lein-env"   . enh-ruby-mode))
  :hook ((clojure-mode       . paredit-mode)
         (clojurescript-mode . paredit-mode)
         (clojurec-mode      . paredit-mode)))

;; eglot
(use-package eglot
  :ensure t
  :hook ((clojure-mode       . eglot-ensure)
         (clojurescript-mode . eglot-ensure)
         (clojurec-mode      . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(clojure-mode       . ("clojure-lsp")))
  (add-to-list 'eglot-server-programs '(clojurescript-mode . ("clojure-lsp")))
  (add-to-list 'eglot-server-programs '(clojurec-mode      . ("clojure-lsp"))))

;; cider
(use-package cider
  :ensure t
  :after clojure-mode
  :hook ((clojure-mode    . cider-mode)
         (cider-repl-mode . paredit-mode))
  :custom
  (cider-save-file-on-load t)
  (cider-repl-display-help-banner nil))

;; company
(use-package company
  :ensure t
  :hook ((clojure-mode    . company-mode)
         (cider-repl-mode . company-mode))
  :custom
  (company-minimum-prefix-length 1))

;; flycheck + clj-kondo
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package flycheck-clj-kondo
  :ensure t
  :after (clojure-mode flycheck))

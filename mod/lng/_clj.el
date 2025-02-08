;; install jdk
;; https://clojure.org/guides/install_clojure#java
;; brew install --cask temurin@21

;; install clojure cli
;; https://clojure.org/guides/install_clojure
;; brew install clojure/tools/clojure

;; clojure modes
(ensure-installed-and-require 'clojure-mode)
(ensure-installed-and-require 'inf-clojure)

;; cider
(ensure-installed-and-require 'cider)
(add-hook 'clojure-mode-hook #'cider-mode)

;; mac-os
(ensure-installed-and-require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; other files
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.clj.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljc.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojurescript-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

;; paredit
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; lsp
;; https://emacs-lsp.github.io/lsp-mode/tutorials/clojure-guide/
(add-hook 'clojure-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojurec-mode-hook 'lsp)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-minimum-prefix-length 1
      lsp-lens-enable t
      lsp-signature-auto-activate nil)

;; cider to company 
;; https://docs.cider.mx/cider/usage/code_completion.html
;; (add-hook 'cider-repl-mode-hook #'company-mode)
;; (add-hook 'cider-mode-hook #'company-mode)
;; joker
;; (ensure-installed-and-require 'flycheck-joker)
;; provides minibuffer documentation for the code you're typing into the repl
;; (add-hook 'cider-mode-hook 'eldoc-mode)
;; clj-kondo
;; https://github.com/borkdude/clj-kondo/blob/master/doc/install.md
;; install clj-kondo to the os level first
;; https://github.com/borkdude/flycheck-clj-kondo
;;(ensure-installed-and-require 'flycheck-clj-kondo)

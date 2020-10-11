;; https://github.com/clojure-emacs/clojure-mode
(ensure-installed-and-require 'clojure-mode)

;; https://docs.cider.mx/cider/usage/cider_mode.html
(ensure-installed-and-require 'cider)
(add-hook 'clojure-mode-hook #'cider-mode)

;; cider to company 
;; https://docs.cider.mx/cider/usage/code_completion.html
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;; flycheck
;;(ensure-installed-and-require 'flycheck-clojure)
;;(eval-after-load 'flycheck '(flycheck-clojure-setup))

;; provides minibuffer documentation for the code you're typing into the repl
(add-hook 'cider-mode-hook 'eldoc-mode)

;; Use clojure mode for other extensions
(add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

;; clj-kondo
;; https://github.com/borkdude/clj-kondo/blob/master/doc/install.md
;; install clj-kondo to the os level first
;; https://github.com/borkdude/flycheck-clj-kondo
(ensure-installed-and-require 'flycheck-clj-kondo)

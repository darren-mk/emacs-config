;;; Map
(add-to-list 'load-path "~/.emacs.d/mod")
(load "_map.el") ;; repositories


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eglot-confirm-server-edits nil nil nil "Customized with use-package eglot")
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type 'cabal-repl)
 '(ignored-local-variable-values
   '((eval put 'test-js-eval 'common-lisp-indent-function 1)
     (eval put 'test-ps-js 'common-lisp-indent-function 1)
     (eval put 'mailer-merge-common-variables 'racket-indent-function
           #'begin)
     (Package . JSON) (Syntax . ANSI-COMMON-LISP)
     (Syntax . ANSI-Common-Lisp) (Base . 10) (Package . CL-USER)
     (Syntax . COMMON-LISP)))
 '(package-selected-packages
   '(amx apheleia cider company corfu crm-custom dockerfile-mode
         doom-themes eglot-fsharp exec-path-from-shell flycheck
         go-mode gotest graphql-mode ido-yes-or-no inf-clojure
         json-mode lsp-pyright lsp-treemacs lsp-ui magit mermaid-mode
         nerd-icons-completion nerd-icons-corfu ocamlformat orderless
         org-ac ox-epub paredit projectile pytest rainbow-delimiters
         restclient rustic solarized-theme spacemacs-theme svelte-mode
         utop web-mode yaml-mode yasnippet))
 '(warning-suppress-types '((lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

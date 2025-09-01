(use-package tuareg
  :ensure t
  :config
  (message "Tuareg mode loaded."))

(use-package eglot
  :hook ((tuareg-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '(tuareg-mode . ("opam" "exec" "--" "ocamllsp")))
  (message "Eglot configured for OCaml/Melange."))

(use-package utop
  :ensure t
  :hook (tuareg-mode . utop-minor-mode)
  :config
  (setq utop-command "opam exec -- utop -emacs"))

;; ocamlformat on save
(use-package ocamlformat
  :ensure t
  :hook ((tuareg-mode . (lambda ()
                          (add-hook 'before-save-hook
                                    #'ocamlformat-before-save nil t))))
  :config
  (message "OCamlformat configured."))

(with-eval-after-load 'utop
  (define-key utop-minor-mode-map (kbd "C-c C-c") #'utop-eval-phrase))

(add-hook 'tuareg-mode-hook
  (lambda ()
    (setq-local comment-column 0)
    ;; Keep comments where you type them:
    (setq-local comment-indent-function (lambda (&optional _arg) 0))
    ;; Optional: don’t try to be clever with OCaml block comments
    (setq-local tuareg-indent-leading-comments nil)))

(add-hook 'tuareg-mode-hook
  (lambda ()
    (setq-local comment-style 'multi-line)
    (setq-local comment-continue "   ")))

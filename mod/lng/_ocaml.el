;; Add opam emacs directory to your load-path by appending this to your .emacs:
(let ((opam-share (ignore-errors (car (process-lines "opam" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)
    ;; To easily change opam switches within a given Emacs session, you can
    ;; install the minor mode https://github.com/ProofGeneral/opam-switch-mode
    ;; and use one of its "OPSW" menus.
    ))

;; https://batsov.com/articles/2022/08/23/setting-up-emacs-for-ocaml-development/

;; Major mode for OCaml programming
(use-package tuareg
  :ensure t
  :mode (("\\.ocamlinit\\'" . tuareg-mode)))

(use-package dune
  :ensure t)

(use-package utop
  :ensure t
  :hook (tuareg-mode . utop-minor-mode))

(use-package merlin
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook #'merlin-mode)
  (add-hook 'merlin-mode-hook #'company-mode)
  (setq merlin-error-after-save nil))

(use-package merlin-eldoc
  :ensure t
  :hook (merlin-mode . merlin-eldoc-setup))

(use-package flycheck-ocaml
  :ensure t
  :config
  (flycheck-ocaml-setup))

(use-package lsp-mode
  :ensure t
  :hook (tuareg-mode . lsp)
  :commands lsp)

(setq utop-command "opam exec -- utop -emacs")

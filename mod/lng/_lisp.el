;; Find sbcl on PATH or fall back to common Homebrew path
(defvar my/sbcl-path
  (or (executable-find "sbcl")
      (cond ((eq system-type 'darwin)    "/opt/homebrew/bin/sbcl") ; Apple Silicon
            ((eq system-type 'gnu/linux) "/usr/bin/sbcl")
            ;; Add Intel macOS fallback if you’re on Intel:
            (t "/usr/local/bin/sbcl"))))

(use-package sly
  :ensure t
  :init
  ;; Correct shape: an alist (symbol ( "cmd" "args"... ))
  (setq sly-lisp-implementations
        `((sbcl (,my/sbcl-path))))
  ;; Optional: pick default if you define multiple implementations
  (setq sly-default-lisp 'sbcl))

;; (Optional) only for SLIME-style fallbacks
(setq inferior-lisp-program my/sbcl-path)

(use-package paredit
  :ensure t
  :hook ((lisp-mode . enable-paredit-mode)
         (lisp-interaction-mode . enable-paredit-mode)
         (sly-mrepl-mode . paredit-mode)))

;; Keep Paredit, but give RET back to the REPL
(add-hook 'sly-mrepl-mode-hook
          (lambda ()
            (paredit-mode 1)
            (local-set-key (kbd "RET") #'sly-mrepl-return)
            (local-set-key (kbd "C-j") #'paredit-newline)
            (electric-indent-local-mode -1)))


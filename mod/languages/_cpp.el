;;;; prerequisite
;;; mac
;; $ brew install llvm
;; $ echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc
;;; fedora (as of vers 42)
;; $ sudo dnf install gcc-c++
;; $ sudo dnf install @development-tools
;; $ sudo dnf install clang clang-tools-extra clang-format

;;; --- Packages & MELPA ---
(setq package-selected-packages
      '(eglot yasnippet helm helm-xref projectile hydra company avy which-key))
(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;;; --- Helm (keep) but avoid Ido conflict ---
;; Turn Ido off BEFORE enabling Helm (they're incompatible).
(when (fboundp 'ido-mode) (ignore-errors (ido-mode -1)))
(setq ido-everywhere nil)

;; Enable Helm + common remaps
(helm-mode 1)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

;;; --- Which-key ---
(which-key-mode 1)

;;; --- Performance tweaks for subprocess IO / servers ---
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

;;; --- company: use capf (eglot-driven) ---
(add-hook 'after-init-hook #'global-company-mode)
(setq company-backends '(company-capf))

;; yas globally
(yas-global-mode 1)

;; clangd path
(let* ((brew-clangd "/opt/homebrew/opt/llvm/bin/clangd")
       (linux-clangd "/usr/bin/clangd")
       (clangd (cond
                ((file-executable-p brew-clangd) brew-clangd)
                ((file-executable-p linux-clangd) linux-clangd)
                (t (message "warn: cland not found")))))
  (setq eglot-server-programs
        `((c-mode . (,clangd))
          (c++-mode . (,clangd)))))
(add-hook 'c-mode-hook  #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)

;; Extras: format/organize on save (respects .clang-format if present)
(defun my-c-cpp-eglot-setup ()
  (add-hook 'before-save-hook #'eglot-format-buffer nil t)
  (add-hook 'before-save-hook
            (lambda ()
              (when (eglot-managed-p)
                (ignore-errors (eglot-code-actions nil nil "source.includeFix"))))
            nil t))
(add-hook 'c-mode-hook  #'my-c-cpp-eglot-setup)
(add-hook 'c++-mode-hook #'my-c-cpp-eglot-setup)

;; handy eglot keys under C-c e
(define-prefix-command 'my-eglot-map)
(global-set-key (kbd "C-c e") 'my-eglot-map)
(define-key my-eglot-map (kbd "r") #'eglot-rename)
(define-key my-eglot-map (kbd "a") #'eglot-code-actions)
(define-key my-eglot-map (kbd "f") #'eglot-format)
(define-key my-eglot-map (kbd "d") #'eldoc)                ;; hover
(define-key my-eglot-map (kbd "g") #'xref-find-definitions)
(define-key my-eglot-map (kbd "b") #'xref-pop-marker-stack)

;;; --- build & run ---

(defun detect-cxx ()
  (or (executable-find "g++")
      (executable-find "clangd++")
      (message "warn: cpp compiler not found")))

(defun cpp-compile-and-run-this ()
  "Compile current .cpp with clang++ into build/<name> and run it."
  (interactive)
  (let* ((src (buffer-file-name))
         (name (file-name-base src))
         (cxx (detect-cxx))
         (cmd (format
               "mkdir -p build && %s -std=c++20 -g -Wall -Wextra %s -o build/%s && ./build/%s"
               (shell-quote-argument cxx)
               (shell-quote-argument src) name name)))
    (save-buffer)
    (compile cmd)))
(global-set-key (kbd "C-c C-x") #'cpp-compile-and-run-this)

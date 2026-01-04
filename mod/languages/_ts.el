;;; -*- lexical-binding: t; -*-

;;; --- TypeScript with lsp-mode (Emacs 29+) ---

;; If you use use-package elsewhere, you can skip this bootstrap.
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))
(unless package--initialized (package-initialize))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

;; Bring shell PATH into GUI Emacs (critical on macOS: enables Node & LSP servers)
(use-package exec-path-from-shell
  :init
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
    ;; Optional but harmless:
    (exec-path-from-shell-copy-env "NODE_PATH")))

;; Use the new Tree-sitter modes
(add-to-list 'auto-mode-alist '("\\.ts\\'"  . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;; Install grammars once: M-x treesit-install-language-grammar RET typescript/tsx
(setq treesit-language-source-alist
      '((typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "typescript/src"))
        (tsx        . ("https://github.com/tree-sitter/tree-sitter-typescript" "tsx/src"))))
(setq treesit-extra-load-path (list (expand-file-name "tree-sitter" user-emacs-directory)))

;;; --- Completion stack: lsp-mode → CAPF → Corfu (+ Orderless, Yas) ---

(use-package corfu
  :init
  (global-corfu-mode 1)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 1)
  (corfu-auto-delay 0.05)
  (corfu-preselect-first nil))

(with-eval-after-load 'corfu
  (require 'corfu-popupinfo)
  (corfu-popupinfo-mode 1))  ;; inline docs/signatures

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((lsp-capf (styles orderless)))))

(use-package yasnippet :init (yas-global-mode 1))

;;; --- LSP Core (only lsp-mode) ---

(use-package lsp-mode
  :hook ((typescript-ts-mode . lsp-deferred)
         (tsx-ts-mode        . lsp-deferred))
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-completion-provider :capf)  ;; let LSP feed CAPF/Corfu
  (lsp-enable-snippet t)
  (lsp-prefer-flymake nil)
  ;; Optional quality-of-life:
  (read-process-output-max (* 1024 1024))  ;; 1MB
  (lsp-idle-delay 0.2))

(use-package lsp-ui :commands lsp-ui-mode)
(use-package which-key :init (which-key-mode 1))
(with-eval-after-load 'lsp-mode
  (lsp-enable-which-key-integration t))

;;; --- Formatting: Prettier on save (Apheleia) ---

(use-package apheleia :init (apheleia-global-mode 1))
(defun my/ts-disable-lsp-formatting ()
  (setq-local lsp-enable-on-type-formatting nil)
  (setq-local lsp-enable-indentation nil))
(add-hook 'typescript-ts-mode-hook #'my/ts-disable-lsp-formatting)
(add-hook 'tsx-ts-mode-hook        #'my/ts-disable-lsp-formatting)

;;; --- ESLint via LSP (vscode-eslint-language-server) ---
;; Ensure your project has eslint + @typescript-eslint/* + vscode-eslint-language-server
;; and a .eslintrc.* file. lsp-mode will auto-detect from node_modules/.bin.

;;; --- Handy LSP keybinds ---

(with-eval-after-load 'lsp-mode
  (define-key lsp-mode-map (kbd "C-c l r") #'lsp-rename)
  (define-key lsp-mode-map (kbd "C-c l a") #'lsp-execute-code-action)
  (define-key lsp-mode-map (kbd "C-c l o") #'lsp-organize-imports))

;;; --- TAB behavior ---

(setq tab-always-indent 'complete
      completion-cycle-threshold 3)

;;; --- Test runner (C-c t) ---


;; Markers we consider a TS subproject root (ordered by preference)
(defvar my/ts-root-markers
  '("tsconfig.json"
    "vitest.config.ts" "vitest.config.js" "vitest.config.mjs" "vitest.config.cjs"
    "jest.config.ts"   "jest.config.js"   "jest.config.mjs"   "jest.config.cjs"
    "package.json"
    ".project-root")                      ;; <- create this file to force-root
  "Files that indicate the nearest TypeScript project root.")

;; Optional hard override (can be set via .dir-locals.el)
(defvar-local my/ts-project-root-override nil
  "If non-nil, use this directory as the TS project root for the current buffer.")

(defun my/ts--nearest-file-up (start files)
  "Return nearest ancestor of START containing any FILES."
  (let* ((dir (file-truename (file-name-as-directory start)))
         (prev nil)
         (hit  nil))
    (while (and dir (not (equal dir prev)) (not hit))
      (dolist (f files)
        (when (and (not hit) (file-exists-p (expand-file-name f dir)))
          (setq hit dir)))
      (setq prev dir
            dir  (file-name-directory (directory-file-name dir))))
    hit))

(defun my/ts--project-root ()
  "Best-effort TS subproject root:
   1) buffer-local override,
   2) nearest TS marker (tsconfig/jest/vitest/package.json/.project-root),
   3) fallback to project.el root,
   4) current directory."
  (or my/ts-project-root-override
      (and (buffer-file-name)
           (my/ts--nearest-file-up (file-name-directory (buffer-file-name))
                                   my/ts-root-markers))
      (when (fboundp 'project-current)
        (when-let ((pr (project-current nil)))
          (ignore-errors (project-root pr))))
      default-directory))

(defun my/ts--detect-test-cmd (root)
  "Pick a sensible test command based on what's in the project."
  (let ((pkg   (expand-file-name "package.json" root))
        (vitest (expand-file-name "node_modules/.bin/vitest" root))
        (jest   (expand-file-name "node_modules/.bin/jest" root)))
    (cond
     ((file-exists-p pkg)
      (with-temp-buffer
        (insert-file-contents pkg)
        (if (save-excursion
              (goto-char (point-min))
              (re-search-forward "\"test\"\\s*:" nil t))
            "npm run test"
          (cond
           ((file-exists-p vitest) "npx vitest run")
           ((file-exists-p jest)   "npx jest --runInBand")
           (t "echo \"No test command found. Add a 'test' script or install vitest/jest.\" && exit 1")))))
     (t "echo \"No package.json here. Run 'npm init -y' first.\" && exit 1"))))

(defun my/ts-test ()
  "Run project tests at the project root."
  (interactive)
  (let* ((root (file-name-as-directory (my/ts--project-root)))
         (default-directory root))
    (compile (my/ts--detect-test-cmd root))))

(with-eval-after-load 'typescript-ts-mode
  (define-key typescript-ts-mode-map (kbd "C-c t") #'my/ts-test))
(with-eval-after-load 'tsx-ts-mode
  (define-key tsx-ts-mode-map (kbd "C-c t") #'my/ts-test))

;;; --- Minimal LSP sanity checks (M-x my/ts-lsp-check) ---

(defun my/ts-lsp-check ()
  "Echo common LSP problems so you don't have to guess."
  (interactive)
  (message "node: %s | ts-ls: %s | tsserver: %s | CAPF has lsp-capf: %s"
           (or (executable-find "node") "NOT FOUND")
           (or (executable-find "typescript-language-server") "NOT FOUND")
           (or (executable-find "tsserver") "NOT FOUND")
           (if (and (boundp 'completion-at-point-functions)
                    (memq 'lsp-completion-at-point completion-at-point-functions))
               "yes" "no")))

;;; --- Run only the current test (Vitest/Jest) ---

(defun my/ts--detect-runner (root)
  "Return 'vitest or 'jest if found in ROOT."
  (let* ((vitest (expand-file-name "node_modules/.bin/vitest" root))
         (jest   (expand-file-name "node_modules/.bin/jest" root))
         (pkg    (expand-file-name "package.json" root))
         (pkgstr (when (file-exists-p pkg)
                   (with-temp-buffer (insert-file-contents pkg)
                                     (buffer-string)))))
    (cond
     ((file-exists-p vitest) 'vitest)
     ((file-exists-p jest)   'jest)
     ((and pkgstr (string-match-p "vitest" pkgstr)) 'vitest)
     ((and pkgstr (string-match-p "jest"   pkgstr)) 'jest)
     (t nil))))

(defun my/ts--current-test-name ()
  "Return the nearest test name around point, or nil.
Looks for it(…)/test(…) and captures the first string argument."
  (save-excursion
    (let ((limit (max (point-min) (- (point) 4000))) ; search up a bit
          (name  nil))
      (when (re-search-backward "\\_<\\(it\\|test\\)\\(\\.only\\)?\\s-*(" limit t)
        (let ((start (point)))
          ;; find first quoted string within ~10 lines after call
          (when (re-search-forward "\\s-*\\([\"'`]\\)\\(\\(?:.\\|\n\\)*?\\)\\1"
                                   (save-excursion (goto-char start)
                                                   (line-end-position 10))
                                   t)
            (setq name (match-string-no-properties 2)))))
      name)))

(defun my/ts--single-test-command (root file testname)
  "Build a shell command to run FILE and optional TESTNAME with the detected runner."
  (let* ((runner (my/ts--detect-runner root))
         (fileq  (shell-quote-argument (file-relative-name file root)))
         (tflag  (when testname (format " -t %s" (shell-quote-argument testname)))))
    (pcase runner
      ('vitest (format "npx vitest run %s%s" fileq (or tflag "")))
      ('jest   (format "npx jest --runInBand %s%s" fileq (or tflag "")))
      (_ "echo \"Cannot detect vitest or jest. Add a test script or install a runner.\" && exit 1"))))

(defun my/ts-test-at-point ()
  "Run only the test case at point (Vitest/Jest)."
  (interactive)
  (let* ((root (file-name-as-directory (my/ts--project-root)))
         (file (buffer-file-name))
         (test (my/ts--current-test-name))
         (default-directory root))
    (unless file (user-error "Current buffer is not visiting a file"))
    (compile (my/ts--single-test-command root file test))))

(defun my/ts-test-file ()
  "Run tests in the current file only."
  (interactive)
  (let* ((root (file-name-as-directory (my/ts--project-root)))
         (file (buffer-file-name))
         (default-directory root))
    (unless file (user-error "Current buffer is not visiting a file"))
    (compile (my/ts--single-test-command root file nil))))

;; Keybinds (keep C-c t for whole project; add these:)
(with-eval-after-load 'typescript-ts-mode
  (define-key typescript-ts-mode-map (kbd "C-c C-t") #'my/ts-test-at-point)
  (define-key typescript-ts-mode-map (kbd "C-c C-f") #'my/ts-test-file))
(with-eval-after-load 'tsx-ts-mode
  (define-key tsx-ts-mode-map (kbd "C-c C-t") #'my/ts-test-at-point)
  (define-key tsx-ts-mode-map (kbd "C-c C-f") #'my/ts-test-file))

;;; Always use spaces, not tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq typescript-ts-mode-indent-offset 2)
(setq tsx-ts-mode-indent-offset 2)   ;; Emacs 29 TSX

;;; Make sure SPACE is a plain self-insert in TS buffers
(with-eval-after-load 'typescript-ts-mode
  (define-key typescript-ts-mode-map (kbd "SPC") #'self-insert-command))
(with-eval-after-load 'tsx-ts-mode
  (define-key tsx-ts-mode-map (kbd "SPC") #'self-insert-command))

;;; If SPACE still jumps to an indent column, turn off electric indent locally
(add-hook 'typescript-ts-mode-hook (lambda () (electric-indent-local-mode -1)))
(add-hook 'tsx-ts-mode-hook        (lambda () (electric-indent-local-mode -1)))

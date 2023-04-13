;; Enable packages.
(ensure-installed-and-require 'js2-mode)
(ensure-installed-and-require 'typescript-mode)
(ensure-installed-and-require 'tide)
(ensure-installed-and-require 'js2-refactor)
(ensure-installed-and-require 'xref-js2)
(ensure-installed-and-require 'prettier-js)
(ensure-installed-and-require 'add-node-modules-path)
(ensure-installed-and-require 'emmet-mode)

;; Add file extension types.
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

;; Enable better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook (lambda ()
  (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; Set indent space.
;; https://emacs.stackexchange.com/questions/37757/how-to-change-indent-size-for-typescript-layer-in-spacemacs
(setq-default typescript-indent-level 2)

;; set up tide
(defun setup-tide-mode ()
  (interactive) ;;;sdfsadfasldfj
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

;; hook languages to TIDE mode
(add-hook 'js-mode-hook #'setup-tide-mode)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; https://gist.github.com/CodyReichert/9dbc8bd2a104780b64891d8736682cea

;; disable the default jslint
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint json-jsonlist)))

;; enable eslint checker when web-mode is activated
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; enable prettier-js-mode for files in a project with prettier (this will use the projects .prettierrc):
(defun web-mode-init-prettier-hook ()
  (add-node-modules-path)
  (prettier-js-mode))
(add-hook 'web-mode-hook 'web-mode-init-prettier-hook)

;; enable emmet-mode with web-mode:
(add-hook 'web-mode-hook  'emmet-mode)

;; activate web-mode when editing .js and .js files:
(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) ;; auto-enable for .js/.jsx files

;; enable JSX syntax highlighting in .js/.jsx files, add this to your emacs configuration:
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))

;; configure indentation and any other preferences in the web-mode-init-hook:
(defun web-mode-init-hook ()
  "Hooks for Web mode. Adjust indent."
  (setq web-mode-markup-indent-offset 4))
(add-hook 'web-mode-hook 'web-mode-init-hook)

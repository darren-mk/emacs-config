;;; -*- lexical-binding: t; -*-

;;; Repositories
(add-to-list 'load-path "~/.emacs.d/mod/packaging")
(load "_repositories.el")
(load "_ensure.el")
(load "_use-package.el")
(load "_path.el")

;;; Navigation
(add-to-list 'load-path "~/.emacs.d/mod/navigation")
(load "_ido.el")
(load "_scroll.el")
(load "_dired.el")
(load "_projectile.el")
(load "_treemacs.el")

;;; Code-editing features
(add-to-list 'load-path "~/.emacs.d/mod/editing")
(load "_path.el")
(load "_magit.el")
(load "_flycheck.el")
(load "_backup.el")
(load "_yesno.el")
(load "_paredit.el")
(load "_autocomplete.el")
(load "_lsp.el")
(load "_eglot.el")
(load "_company.el")
(load "_yasnippet.el")
(load "_indent.el")
(load "_vterm.el")
(load "_aidermacs.el")

;;; Load UI configs
(add-to-list 'load-path "~/.emacs.d/mod/visual")
(load "_bar.el") ;; bar
(load "_line.el") ;; line
(load "_space.el") ;; space
(load "_font.el") ;; font
(load "_rainbow.el") ;; rainbow delimiters
(load "_showparen.el") ;; show-paren-mode

;;; Load language configs
(add-to-list 'load-path "~/.emacs.d/mod/languages")
(load "_el.el")
(load "_org.el")
(load "_web.el")
(load "_rest.el")
(load "_yaml.el")
(load "_dockerfile.el")
(load "_sql.el")
(load "_md.el")
(load "_mmd.el")
(load "_gql.el")
(load "_cpp.el")
(load "_clj.el")
(load "_fs.el")
(load "_go.el")
(load "_ocaml.el")
(load "_rust.el")
(load "_py.el")
(load "_ts.el")
(load "_js.el")

;;; Load theme configs
(add-to-list 'load-path "~/.emacs.d/mod/themes")
(load "_ef.el")

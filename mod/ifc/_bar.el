;; hide menu bar
(menu-bar-mode -1)

;; hide scroll bar
(toggle-scroll-bar -1)

;; hide tool bar 
(tool-bar-mode -1)

;; show line numbers.
(global-linum-mode)

;; remove the graphical toolbar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; hide native OS scroll bars
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; hide startup page
(setq inhibit-startup-screen t)

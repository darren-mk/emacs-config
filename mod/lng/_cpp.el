;; https://www.youtube.com/watch?v=HTUE03LnaXA
(defun ac-c-header-init ()
  (ensure-installed-and-require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

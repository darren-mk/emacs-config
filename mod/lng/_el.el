; https://www.emacswiki.org/emacs/ParEdit
(add-hook 'emacs-lisp-mode-hook
	  #'enable-paredit-mode)
(add-hook 'ielm-mode-hook
	  #'enable-paredit-mode)

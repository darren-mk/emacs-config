;; save customize changes somewhere separate from init.el
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file 'noerror 'nomessage))

;; map
(add-to-list 'load-path "~/.emacs.d/mod")
(load "_map.el")

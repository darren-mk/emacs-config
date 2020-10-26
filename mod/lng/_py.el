;; elpy
;; https://github.com/jorgenschaefer/elpy
(ensure-installed-and-require 'elpy)
(elpy-enable)
;; flycheck 
(when (require 'flycheck nil t)
  ;;(defvar elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

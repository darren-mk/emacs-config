(ensure-installed-and-require 'csharp-mode)
(ensure-installed-and-require 'omnisharp)

(add-hook 'csharp-mode-hook 'omnisharp-mode)

(defun my-csharp-mode-hook ()
  ;; enable the stuff you want for C# here
  (electric-pair-mode 1)       ;; Emacs 24
  (electric-pair-local-mode 1) ;; Emacs 25
  )
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

(eval-after-load
 'company
 '(add-to-list 'company-backends 'company-omnisharp))
(add-hook 'csharp-mode-hook #'company-mode)

(add-hook 'csharp-mode-hook #'flycheck-mode)


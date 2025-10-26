(ensure-installed-and-require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 2
      company-selection-wrap-around t
      company-show-numbers t
      company-dabbrev-downcase nil
      company-echo-delay 0
      company-tooltip-limit 20
      company-transformers '(company-sort-by-occurrence)
      company-begin-commands '(self-insert-command))
(add-hook 'after-init-hook 'global-company-mode)
(global-company-mode)

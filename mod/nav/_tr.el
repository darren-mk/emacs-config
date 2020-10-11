(add-to-list 'load-path "~/.emacs.d/_neotree")
(ensure-installed-and-require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq-default neo-show-hidden-files t)

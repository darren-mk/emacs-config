;; install org more 
(ensure-installed-and-require 'org)
(ensure-installed-and-require 'ox-epub)
;; integrate with ac
;; https://github.com/aki2o/org-ac
(ensure-installed-and-require 'org-ac)
(org-ac/config-default)

;;; -*- lexical-binding: t; -*-

(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;;
(ensure-installed-and-require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

;;
(ensure-installed-and-require 'amx)
(amx-mode 1)

;;
(ensure-installed-and-require 'ido-yes-or-no)
(ido-yes-or-no-mode 1)

;;
(ensure-installed-and-require 'crm-custom)
(crm-custom-mode 1)

;;
(ensure-installed-and-require 'icomplete)
(icomplete-mode 1)

(cond
 ((eq system-type 'gnu/linux)
  (let ((font-list '("Bitstream Vera Sans Mono-9"
                     "DejaVu Sans Mono-9"
                     "monospace-9")))
    (catch 'found
      (dolist (font font-list)
        (when (find-font (font-spec :name font))
          (add-to-list 'default-frame-alist `(font . ,font))
          (set-face-attribute 'default t :font font :height 110)
          (throw 'found font))))))
 ((eq system-type 'darwin) nil))

;; ----- zoom keys (buffer-local text scale) -----
;; C-= : zoom in, C-- : zoom out, C-0 : reset
(global-set-key (kbd "C-=") #'text-scale-increase)
(global-set-key (kbd "C-+") #'text-scale-increase)  ;; some keyboards send C-+
(global-set-key (kbd "C--") #'text-scale-decrease)
(global-set-key (kbd "C-0") (lambda () (interactive) (text-scale-set 0)))

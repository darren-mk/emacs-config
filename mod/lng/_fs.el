(ensure-installed-and-require 'fsharp-mode)


;; fontomas implementation
;; https://zwild.github.io/posts/emacs-as-a-fsharp-ide-part1/
(defun fsharp-fantomas-format-region (start end)
  (interactive "r")
  (let ((source (shell-quote-argument (buffer-substring-no-properties start end)))
	(ok-buffer "*fantomas*")
	(error-buffer "*fantomas-errors*"))
    (save-window-excursion
      (shell-command-on-region
       start end (format "fantomas --indent 2 --pageWidth 99 --stdin %s --stdout"
			 source)
       ok-buffer nil error-buffer)
      (if (get-buffer error-buffer)
	  (progn
	    (kill-buffer error-buffer)
	    (message "Can't format region."))
	(delete-region start end)
	(insert (with-current-buffer ok-buffer
		  (s-chomp (buffer-string))))
	(delete-trailing-whitespace)
	(message "Region formatted.")))))

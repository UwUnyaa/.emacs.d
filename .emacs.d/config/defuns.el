;; this file should load after extensions

;; a function to launch impatient-mode quicker
(defun my-impatient-mode()
  "A function that automatically enables impatient-mode along with httpd server if it isn't running."
  (interactive)
  (when (not (process-status "httpd"))
    (httpd-start))
  (impatient-mode))

;; C-c TAB in almost all modes
(defun indent-buffer ()
  "Indent the whole buffer."
  (interactive)
  (indent-region (point-min) (point-max))
  (delete-trailing-whitespace))

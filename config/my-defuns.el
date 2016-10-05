;; this file should load after extensions

;; a function to launch impatient-mode quicker
(defun my-impatient-mode()
  "A function that automatically enables impatient-mode along
with httpd server if it isn't running."
  (interactive)
  (unless (process-status "httpd")
    (httpd-start))
  (impatient-mode))

(defun my-lhttpd (&optional arg)
  "Start a local http server in the current directory on port
8000 or the prefix argument."
  (interactive "P")
  (setq httpd-root default-directory)
  (setq httpd-port (or arg 8000))
  (httpd-start)
  (message "Started a local http server at port %d in %s"
           httpd-port httpd-root))

;; C-c TAB from web-mode in almost all modes
(defun my-indent-buffer ()
  "Indent the whole buffer."
  (interactive)
  (indent-region (point-min) (point-max))
  (delete-trailing-whitespace))

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

;; a command to insert block comments in js2-mode
(defun my-js2-comment-block (&optional beg end)
  "Inserts a block comment at point or wraps region in a block
comment."
  ;; this code is bad, but it's a quick hack for now
  (interactive
   (when (use-region-p)
     (list (region-beginning) (region-end))))
  (if beg                               ; if region is active
      (let ((current-point (point)))
        (goto-char beg)
        (insert "/* ")
        (goto-char (+ end 3))
        (insert " */")
        (goto-char
         (+ current-point
            (if (> beg end)
                3
              6))))
    (insert "/*  */")
    (backward-char 3)))

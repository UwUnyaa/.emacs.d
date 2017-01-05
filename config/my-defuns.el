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

;; escapes non-ASCII characters in region
(defun my-js2-unicode-escape-region (beg end)
  "Escapes non-ASCII characters as JavaScript unicode escapes.
Doesn't handle all characters as of now."
  (interactive "r")
  (let ((unescaped (buffer-substring-no-properties beg end)))
    (delete-region beg end)
    (insert
     (with-temp-buffer
       (insert unescaped)
       (goto-char (point-min))
       (while (< (point) (point-max))
         (let ((char (char-after)))
           (if (> char 127)             ; non-ASCII
               (progn (delete-char 1)
                      (insert (format "\\u%04X" char)))
             (forward-char))))
       (buffer-substring-no-properties (point-min) (point-max))))))

(defun my-dired-do-org-export (backend)
  "Exports marked files or file at point with a backend read from
a minibuffer. Files without .org extension are ignored. Alist of
backends is defined in `my-dired-org-export-backends-alist'."
  (interactive
   (list (cdr (assoc (completing-read
                      "Org export format: "
                      my-dired-org-export-backends-alist)
                     my-dired-org-export-backends-alist))))
  (mapc (lambda (file)
          (with-current-buffer (find-file-noselect file)
            (funcall backend file)
            (kill-buffer)))
        (dired-get-marked-files
         t nil
         (lambda (file)              ; filter out files without .org extension
           (let ((extension (file-name-extension file)))
             (when extension
               (string-equal "org" (downcase extension))))))))

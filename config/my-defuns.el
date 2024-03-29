;; this file should load after extensions

(require 'cl-macs)

(defun my-straight-require-from-github (repo-info)
  "Use a package from github described by REPO-INFO.

REPO-INFO must be a list, which should contain the name of the
repository in question, and optionally the package name, which
should map to the matching feature in it."
  (let* ((repo-name (car repo-info))
          (package-name (or (cadr repo-info)
                            (intern (cadr (split-string repo-name "/"))))))
     (straight-use-package
      `(,package-name :type git :host github :repo ,repo-name))))

(defun my-lhttpd (&optional port)
  "Start a local http server in the current directory on port
8000 or the prefix argument."
  (interactive "P")
  (setq httpd-root default-directory
        httpd-port (or port 8000))
  (httpd-start)
  (message "Started a local http server at port %d in %s"
           httpd-port httpd-root))

(defun my-indent-buffer ()
  "Indent the whole buffer like in `web-mode'."
  (interactive)
  (indent-region (point-min) (point-max))
  (delete-trailing-whitespace))

(defun my-js2-set-indent (level)
  "Set indent level in `js2-mode' to LEVEL."
  (interactive "nNew indent level: ")
  (setq-local js2-basic-offset level))

(defun my-js2-unicode-escape-region (beg end)
  "Escape non-ASCII characters as JavaScript unicode escapes.
Doesn't handle all characters as of now."
  (interactive "r")
  (let ((string (buffer-substring-no-properties beg end)))
    (delete-region beg end)
    (insert
     (mapconcat
      (lambda (char)
        (if (> char 127)                ; non-ASCII
            (format "\\u%04X" char)
          (char-to-string char)))
      string ""))))

(defun my-setup-tide-mode ()
  "Setup tide-mode."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (when (fboundp #'my-company-tide-capf)
    (make-local-variable 'completion-at-point-functions)
    (push #'my-company-tide-capf completion-at-point-functions)))

(defun my-js2-change-context (context)
  "Switch current `js2-mode' buffer to specified context.

A list of contexts should be defined in `my-js2-contexts-list'."
  (interactive
   (list (completing-read "New context: " my-js2-contexts-list)))
  (cl-flet ((context-symbol
             (context)
             (intern (concat "js2-include-" context "-externs"))))
    (let ((desired-context (context-symbol context))
          (contexts-list (mapcar #'context-symbol my-js2-contexts-list)))
      (mapc (lambda (context)
              ;; this is pretty much `setq-local', but that macro doesn't have
              ;; an equivalent that doesn't quote the symbol
              (set (make-local-variable context)
                   (eq context desired-context)))
            contexts-list)
      ;; make sure that `js2-mode' parses the file again according to selected
      ;; context
      (js2-reparse))))

(defun my-ox-require-backends ()
  "Make sure all ox backends defined in `my-ox-backends' are
loaded."
  (mapc #'require my-ox-backends))

(defun my-dired-xdg-open ()
  "Open the file at point with xdg-open."
  (interactive)
  (browse-url-xdg-open (dired-get-file-for-visit)))

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
            (funcall backend)
            (kill-buffer)))
        (dired-get-marked-files
         t nil
         (lambda (file)              ; filter out files without .org extension
           (let ((extension (file-name-extension file)))
             (when extension
               (string-equal "org" (downcase extension)))))))
  (revert-buffer))

(defun my-org-confirm-babel-evaluate (lang body)
  "Skip prompts for executing code blocks in certain languages."
  (ignore body)
  (memq lang '(restclient)))

(defun my-simple-capitalize (str)
  "Capitalize the first letter and ignores the rest."
  (if (string-empty-p str)
      ""
      (let ((first (substring str 0 1))
            (rest  (substring str 1)))
        (concat (upcase first) rest))))

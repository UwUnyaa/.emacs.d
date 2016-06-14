;; this file should load after extensions

;; indentation in web-mode (2 spaces per level)
(defun my-web-mode-hook-indentation ()
  "Customized web-mode indentation"
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook-indentation)

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

;;; custom aliases and keybindings for functions defined in this file
;; aliases
(defalias 'im 'my-impatient-mode)
(defalias 'rs 'replace-string)
(defalias 'yes-or-no-p 'y-or-n-p)       ; y/n instead of yes/no

;; keybindings
(global-set-key (kbd "C-c C-i") 'indent-buffer)

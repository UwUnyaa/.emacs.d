;; load autoload files
(mapc #'load
      (directory-files-recursively "~/.emacs.d/lisp" "^autoloads\\.el$"))

;; load config files (order is important)
(mapc #'load
      '("~/.emacs.d/config/my-defuns.el"
        "~/.emacs.d/config/my-lexical.el"
        "~/.emacs.d/config/my-customization.el"
        "~/.emacs.d/config/my-platform-specific.el"
        "~/.emacs.d/config/my-extensions.el"
        "~/.emacs.d/config/my-indentation.el"
        "~/.emacs.d/config/my-local-variables.el"))

;; load additional config files if they exist
(load "~/.emacs.d/config/my-local.el" t)

;; add local lisp directory to load-path if it exists
(let ((local-lisp-dir "~/.emacs.d/lisp/local"))
  (when (file-exists-p local-lisp-dir)
    (add-to-list 'load-path local-lisp-dir)))

;; load autoload files
(mapc #'load
      (directory-files-recursively "~/.emacs.d/lisp" "^autoloads\\.el$"))

;; load config files (order is important)
(mapc #'load
      '("~/.emacs.d/config/my-defuns.el"
        "~/.emacs.d/config/my-lexical.el"
        "~/.emacs.d/config/my-customization.el"
        "~/.emacs.d/config/my-extensions.el"
        "~/.emacs.d/config/my-local-variables.el"))

;; load additional config files if they exist
(load "~/.emacs.d/config/my-local.el" t)

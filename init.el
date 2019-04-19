;; load config files (order is important)
(mapc #'load
      '("~/.emacs.d/config/my-straight-init.el"
        "~/.emacs.d/config/my-straight-packages.el"
        "~/.emacs.d/config/my-defuns.el"
        "~/.emacs.d/config/my-defuns-lexical.el"
        "~/.emacs.d/config/my-customization.el"
        "~/.emacs.d/config/my-extensions.el"
        "~/.emacs.d/config/my-safe-local-variables.el"))

;; load additional config files if they exist
(load "~/.emacs.d/config/my-local.el" t)

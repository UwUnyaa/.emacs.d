(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (wombat)))
 '(default-input-method "japanese")
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(indent-tabs-mode nil)
 '(menu-bar-mode nil)
 '(nxml-slash-auto-complete-flag t)
 '(read-quoted-char-radix 16)
 '(sentence-end-double-space nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

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

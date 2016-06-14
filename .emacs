(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode t)
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
 '(show-paren-mode t))

;; load-path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; load parts of config (order is important)
(load "~/.emacs.d/config/defuns.el")
(load "~/.emacs.d/config/customization.el")
(load "~/.emacs.d/config/platform-specific.el")
(load "~/.emacs.d/config/extensions.el")
(load "~/.emacs.d/config/indentation.el")

;; load additional config files if they exist
(load "~/.emacs.d/config/local.el" t)

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

;; blinking cursor
(blink-cursor-mode 1)

;; use C-h like readlne
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-?") 'help-command) ;new binding for help prefix

;; no sounds
(setq visible-bell nil)

;; no startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message "") ;empty scratch buffer

;; frame title if not started as a daemon
(setq frame-title-format "Emacs")

;; autosave every 60 seconds
(setq auto-save-timeout 60)

;; load parts of config (order is important)
(load-file "~/.emacs.d/config/platform-specific.el")
(load-file "~/.emacs.d/config/extensions.el")
(load-file "~/.emacs.d/config/defuns.el")
(load-file "~/.emacs.d/config/indentation.el")

;; load additional config files if they exist
(my-load-file-if-it-exists "~/.emacs.d/config/local.el")

;; disable warnings
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

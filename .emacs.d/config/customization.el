;;; This file contains customizations of Emacs and modes that are built into it

;;; Personal customizations
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
;; frame title
(setq frame-title-format "Emacs")
;; autosave every 60 seconds
(setq auto-save-timeout 60)
;; disable warnings
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

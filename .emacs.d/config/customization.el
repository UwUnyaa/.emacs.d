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

;;; Org-mode
(add-hook 'org-mode-hook
          (lambda ()
            ;; make M-h behave just like everywhere else
            (define-key org-mode-map (kbd "M-h") 'backward-kill-word)
            ;; use meta shift f/b/n/p instead of meta arrow keys
            (define-key org-mode-map (kbd "M-F") 'org-metaright)
            (define-key org-mode-map (kbd "M-B") 'org-metaleft)
            (define-key org-mode-map (kbd "M-P") 'org-metaup)
            (define-key org-mode-map (kbd "M-N") 'org-metadown)))
;; display org-mode buffers with indentation
(setq org-startup-indented t)
;; custom ellipsis
(setq org-ellipsis " ⤵")
;; wrap lines
(setq org-startup-truncated nil)
;; insert a timestamp when a task is done
(setq org-log-done 'time)
;; syntax highlighting in source code blocks
(setq org-src-fontify-natively t)

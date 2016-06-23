;;; This file contains customizations of Emacs and modes that are built into it

;;; Custom keybindings
;; use C-h like readlne
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-?") 'help-command) ;new binding for help prefix
;; Use C-x C-h for marking paragraphs
(global-set-key (kbd "C-x C-h") 'mark-paragraph)
;; other keybindings
(global-set-key (kbd "C-c C-i") 'indent-buffer)
(global-set-key (kbd "C-c i") 'my-impatient-mode)

;;; Other customizations
;; no sounds
(setq visible-bell nil)
;; no startup message
(setq inhibit-startup-message t)
;; empty scratch buffer
(setq initial-scratch-message nil)
;; blinking cursor
(blink-cursor-mode 1)
;; frame title
(setq frame-title-format "Emacs")
;; fill-column
(setq-default fill-column 80)
;; autosave every 60 seconds
(setq auto-save-timeout 60)
;; disable warnings
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;; aliases
(defalias 'im 'my-impatient-mode)
(defalias 'rs 'replace-string)
(defalias 'yes-or-no-p 'y-or-n-p)       ; y/n instead of yes/no

;;; Org-mode
(add-hook 'org-mode-hook
          (lambda ()
            ;; make M-h behave just like everywhere else
            (define-key org-mode-map (kbd "M-h") 'backward-kill-word)
            ;; use C-x C-h for marking paragraphs
            (define-key org-mode-map (kbd "C-x C-h") 'org-mark-element)
            ;; use meta shift f/b/n/p instead of meta arrow keys
            (define-key org-mode-map (kbd "M-F") 'org-metaright)
            (define-key org-mode-map (kbd "M-B") 'org-metaleft)
            (define-key org-mode-map (kbd "M-P") 'org-metaup)
            (define-key org-mode-map (kbd "M-N") 'org-metadown)
            ;; use control meta shift f/b/n/p instead of meta shift arrow keys
            (define-key org-mode-map (kbd "C-M-S-f") 'org-shiftmetaright)
            (define-key org-mode-map (kbd "C-M-S-b") 'org-shiftmetaleft)
            (define-key org-mode-map (kbd "C-M-S-n") 'org-shiftmetadown)
            (define-key org-mode-map (kbd "C-M-S-p") 'org-shiftmetaup)))
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

;;; This file contains customizations of Emacs and modes that are built into it

;;; Custom keybindings
;; use C-h like readlne
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-?") 'help-command) ; new binding for help prefix
;; Use C-x C-h for marking paragraphs
(global-set-key (kbd "C-x C-h") 'mark-paragraph)
;; other keybindings
(global-set-key (kbd "C-c C-i") 'my-indent-buffer)
(global-set-key (kbd "C-c i") 'my-impatient-mode)
(global-set-key (kbd "C-c l") 'my-lhttpd)

;; use `ibuffer' instead of `list-buffers'
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;; Other customizations
(setq visible-bell nil                  ; no sounds
      inhibit-startup-message t         ; no startup message
      initial-scratch-message nil       ; empty scratch buffer
      frame-title-format "Emacs"        ; frame title
      auto-save-timeout 60)             ; autosave every 60 seconds

;; blinking cursor
(blink-cursor-mode 1)

;; automatically match pairs
(electric-pair-mode)
;; make C-h remove pairs like DEL does in `electric-pair-mode'
(define-key electric-pair-mode-map (kbd "C-h") 'electric-pair-delete-pair)

;; use `ido-mode' for switching buffers only
(ido-mode 'buffers)

;; fill-column
(setq-default fill-column 78)

;; disable warnings
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;; aliases
(defalias 'im 'my-impatient-mode)
(defalias 'rs 'replace-string)
(defalias 'yes-or-no-p 'y-or-n-p)       ; y/n instead of yes/no

;; run eldoc-mode in emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

;; use auto-fill-mode in text-mode and org-mode
(add-hook 'text-mode-hook 'auto-fill-mode)

;;; Org-mode
(add-hook 'org-mode-hook
          (lambda ()
            ;; don't wrap lines
            (toggle-truncate-lines 1)
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
            (define-key org-mode-map (kbd "C-M-S-p") 'org-shiftmetaup)
            ;; move by paragraphs with M-n and M-p
            (define-key org-mode-map (kbd "M-n") 'org-forward-paragraph)
            (define-key org-mode-map (kbd "M-p") 'org-backward-paragraph)))
;;; other org-mode customization
(setq org-startup-indented t       ; display org-mode buffers with indentation
      org-ellipsis "⤵"             ; custom ellipsis
      org-startup-folded nil       ; display files without folding them
      org-startup-truncated nil    ; wrap lines
      org-log-done 'time           ; insert a timestamp when a task is done
      org-src-fontify-natively t)  ; syntax highlighting in source code blocks

;;; dired
(defvar my-dired-org-export-backends-alist
  '(("html" . org-html-export-to-html)
    ("sfhp" . org-sfhp-export-to-file)
    ("text" . org-ascii-export-to-ascii)
    ("pdf"  . org-latex-export-to-pdf))
  "Alist of org export formats and functions used by them. Used
by `my-dired-do-org-export'.")

(setq dired-dwim-target t
      dired-listing-switches "-Al")     ; don't show . and .. in file listings

(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map "E" 'my-dired-do-org-export)
            (define-key dired-mode-map "r" (my-dired-toggle-switch "R"))
            (define-key dired-mode-map "h" (my-dired-toggle-switch "A"))))

;; change displayed major mode names
(mapc #'my-change-major-mode-name
      '((js2-mode              . "JS2")
        (emacs-lisp-mode       . "Elisp")
        (lisp-interaction-mode . "Elisp interaction")
        (completion-list-mode  . "Completions")))

;;; This file contains customization of things that come with Emacs

;;; coding system
(prefer-coding-system 'utf-8)

;; load wombat theme
(load-theme 'wombat t)

(defconst my-can-use-fancy-bindings (or (display-graphic-p) (daemonp))
  "Can binds that aren't terminal friendly be used.")

;;; Custom keybindings
(when my-can-use-fancy-bindings         ; don't rebind in a terminal
  ;; use C-h like readlne
  (global-set-key (kbd "C-h") #'delete-backward-char)
  (global-set-key (kbd "M-h") #'backward-kill-word)
  (global-set-key (kbd "C-?") #'help-command) ; new binding for help prefix
  ;; Use C-x C-h for marking paragraphs
  (global-set-key (kbd "C-x C-h") #'mark-paragraph))

;; other keybindings
(global-set-key (kbd "C-c C-i") #'my-indent-buffer)
(global-set-key (kbd "C-c w") #'delete-trailing-whitespace)
(global-set-key (kbd "C-c l") #'my-lhttpd)
(global-set-key (kbd "C-c f") #'find-file-at-point)

;; use `ibuffer' instead of `list-buffers'
(global-set-key (kbd "C-x C-b") #'ibuffer)

;; make `dabbrev' case sensitive
(setq dabbrev-case-fold-search nil)

;; try configuring fonts to my preferences
(when (and (display-graphic-p)
           (member "DejaVu Sans Mono" (font-family-list)))
  (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9")))

;; set the font for server frames
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9"))

;;; Other customizations
(setq ring-bell-function #'ignore
      visible-bell nil                  ; no sounds
      inhibit-startup-message t         ; no startup message
      initial-scratch-message nil       ; empty scratch buffer
      frame-title-format (if (daemonp)  ; frame title
                             "Emacs (server)"
                           "Emacs")
      auto-save-timeout 60              ; autosave every 60 seconds
      frame-resize-pixelwise t          ; resize graphical frames by pixels
      ido-default-buffer-method 'selected-window
      use-short-answers t
      shr-use-fonts nil                 ; no proportional fonts in `eww'
      ;; variables that were set by custom-set-variables before
      custom-enabled-themes '(wombat)
      default-input-method "japanese"
      display-time-24hr-format t
      read-quoted-char-radix 16
      sentence-end-double-space nil)

;;; global minor modes
(blink-cursor-mode)                     ; blink the cursor
(display-time-mode)                     ; display time in mode line
(show-paren-mode)                       ; highlight the matching paren
(ido-mode 'buffers)                     ; switch buffers with `ido-mode'
(global-subword-mode)                   ; use subword-mode everywhere

;;; hide the tool, scroll and menu bars
(mapc
 (lambda (feature-sym)
   (when (featurep feature-sym)
     (funcall (intern (format "%s-mode" feature-sym)) -1)))
 '(tool-bar scroll-bar menu-bar))

;;; default variables
(setq-default fill-column 78            ; fill-column
              indent-tabs-mode nil)     ; don't indent with tabs

;;; disable warnings
(mapc
 (lambda (warning)
   (put warning 'disabled nil))
 '(set-goal-column narrow-to-region downcase-region upcase-region))

;;; aliases
(defalias 'rs 'replace-string)

;; use `auto-fill-mode' in `text-mode' and `org-mode'
(add-hook 'text-mode-hook #'auto-fill-mode)

;;; indentation
(setq js-indent-level 2
      css-indent-offset 2)

;;; `org-mode'
(setq org-startup-indented t       ; display `org-mode' buffers with indentation
      org-ellipsis "⤵"             ; custom ellipsis
      org-startup-folded nil       ; display files without folding them
      org-startup-truncated nil    ; wrap lines
      org-log-done 'time           ; insert a timestamp when a task is done
      org-src-fontify-natively t   ; syntax highlighting in source code blocks
      org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)

(defvar my-ox-backends '(ox-md ox-sfhp ox-reveal)
  "List of org export backends to be loaded by
`my-ox-require-backends'.")

(add-hook 'org-mode-hook
          (lambda ()
            (toggle-truncate-lines 1)))       ; don't wrap lines

(with-eval-after-load 'org
  (my-ox-require-backends)
  ;; add support for more languages with org-babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((js . t)))
;;; keybindings
  ;; make M-h behave just like everywhere else
  (when my-can-use-fancy-bindings
    (define-key org-mode-map (kbd "M-h") #'backward-kill-word))
  ;; use C-x C-h for marking paragraphs
  (define-key org-mode-map (kbd "C-x C-h") #'org-mark-element)
  ;; use meta shift f/b/n/p instead of meta arrow keys
  (define-key org-mode-map (kbd "M-F") #'org-metaright)
  (define-key org-mode-map (kbd "M-B") #'org-metaleft)
  (define-key org-mode-map (kbd "M-P") #'org-metaup)
  (define-key org-mode-map (kbd "M-N") #'org-metadown)
  ;; use control meta shift f/b/n/p instead of meta shift arrow keys
  (when my-can-use-fancy-bindings
    (define-key org-mode-map (kbd "C-M-S-f") #'org-shiftmetaright)
    (define-key org-mode-map (kbd "C-M-S-b") #'org-shiftmetaleft)
    (define-key org-mode-map (kbd "C-M-S-n") #'org-shiftmetadown)
    (define-key org-mode-map (kbd "C-M-S-p") #'org-shiftmetaup))
  ;; move by paragraphs with M-n and M-p
  (define-key org-mode-map (kbd "M-n") #'org-forward-paragraph)
  (define-key org-mode-map (kbd "M-p") #'org-backward-paragraph))

;;; `dired'
(setq dired-dwim-target t
      dired-listing-switches "-Al")     ; don't show . and .. in file listings

(defvar my-dired-org-export-backends-alist
  '(("html"     . org-html-export-to-html)
    ("sfhp"     . org-sfhp-export-to-file)
    ("text"     . org-ascii-export-to-ascii)
    ("pdf"      . org-latex-export-to-pdf)
    ("markdown" . org-md-export-to-markdown))
  "Alist of org export formats and functions used by them. Used
by `my-dired-do-org-export'.")

(with-eval-after-load 'dired
  (my-ox-require-backends)
;;; keybindings
  (define-key dired-mode-map (kbd "E") #'my-dired-do-org-export)
  (define-key dired-mode-map (kbd "r") (my-dired-switch-toggler "R"))
  (define-key dired-mode-map (kbd "h") (my-dired-switch-toggler "A"))
  (define-key dired-mode-map (kbd "f") #'my-dired-xdg-open))

;;; use human readable file sizes in if they'll work
(when (or (member system-type '(ms-dos windows-nt haiku)) ; ls in elisp
          (eq 0 (call-process insert-directory-program ; check if ls -h works
                              nil nil nil "-h")))
  (setq dired-listing-switches (concat dired-listing-switches "h")))

;;; `nxml-mode'
(setq nxml-slash-auto-complete-flag t)  ; close tags after typing "</"

(with-eval-after-load 'nxml-mode
  (when my-can-use-fancy-bindings
    (define-key nxml-mode-map (kbd "M-h") #'backward-kill-word))
  (define-key nxml-mode-map (kbd "C-x C-h") #'nxml-mark-paragraph)
  (define-key nxml-mode-map (kbd "C-c C-i") #'my-indent-buffer))

;; disable `auto-fill-mode' (this mode doesn't derive from `prog-mode' for
;; some reason)
(add-hook 'nxml-mode-hook
          (lambda ()
            (auto-fill-mode -1)))

;; `typescript-ts-mode'
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))

;; `tsx-ts-mode'
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

;;; `c-mode'
(setq c-default-style "k&r"
      c-basic-offset 2)

;;; change displayed major mode names
(mapc #'my-change-major-mode-name
      '((js2-mode              . "JS2")
        (typescript-ts-mode    . "TS")
        (emacs-lisp-mode       . "Elisp")
        (lisp-interaction-mode . "Elisp interaction")
        (completion-list-mode  . "Completions")))

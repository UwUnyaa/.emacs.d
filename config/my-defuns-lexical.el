;; -*- lexical-binding:t -*-

;; this file contains code that relies on lexical binding

(defun my-change-major-mode-name (mode &optional name)
  "Change the displayed major mode name.

MODE-OR-PAIR can be a symbol with the major mode or a cons with
that symbol and the desired name. In that case NAME can be
ommited.

\(fn mode-or-pair name)"
  ;; handle the case when MODE-OR-PAIR is a cons
  (when (consp mode)
    (setq name (cdr mode)
          mode (car mode)))
  (add-hook (intern (concat (symbol-name mode) "-hook"))
            (lambda ()
              (setq mode-name name))))

(defun my-js2-define-context-mode (context)
  "Define context modes for `js2-mode'. CONTEXT is a string with
the name of a context."
  (fset (intern (format "my-js2-%s-mode" context))
        (lambda ()
          (interactive)
          (js2-mode)
          (my-js2-change-context context))))

(defun my-dired-switch-toggler (switch)
  "Return a closure that toggles switch SWITCH in dired."
  (lambda ()
    (interactive)
    (let ((case-fold-search nil)
          new-switches)
      (if (string-match switch dired-actual-switches)
          (setq new-switches
                (replace-regexp-in-string switch "" dired-actual-switches))
        (setq new-switches (concat dired-actual-switches switch)))
      (dired-sort-other new-switches))))

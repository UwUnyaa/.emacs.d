;;; smart-rebind.el --- rebind keys in all major modes

;;; Code:

(eval-when-compile
  (require 'cl))

(defvar smart-rebind-keys-list '()
  "List used internally by `smart-rebind-keys'. Do not modify it
on your own.")

;; List of lists, car of each is a cons with keys FROM and TO. Cdr is a list
;; of major modes in which that pair was already rebound.

;;;###autoload
(defun smart-rebind-keys (from to)
  "Rebinds FROM to TO in all major modes. Both arguments should
be specified as strings."
  (let ((from-key (kbd from))
        (to-key (kbd to)))
    (push (list (cons from-key to-key)) smart-rebind-keys-list)
    (smart-rebind--in-keymap from-key to-key)
    (add-hook 'after-change-major-mode-hook
              #'smart-rebind-hook-function
              t)))                      ; append

(defun smart-rebind-hook-function ()
  "Internal function for `smart-rebind-keys' run on major mode change."
  ;; local mode map isn't always set, for instance in `fundamental-mode'
  (let ((current-map (current-local-map)))
    (when current-map
      (setq smart-rebind-keys-list
            (mapcar
             (lambda (set)
               ;; if the pair of keys was rebound already in current major
               ;; mode
               (if (member major-mode (cdr set))
                   ;; return it as is
                   set
                 ;; else rebind keys in that mode
                 (smart-rebind--in-keymap
                  (caar set) (cdar set) current-map)
                 ;; add current major mode to the list of modes where
                 ;; rebinding was done already
                 `(,@set ,major-mode)))
             smart-rebind-keys-list)))))

(defun smart-rebind--in-keymap (from to &optional keymap)
  "Rebinds FROM to TO in KEYMAP or globally if it's nil."
  (let* ((from-binding
          (if keymap
              (lookup-key keymap from t)
            (key-binding from)))
         (args (list to from-binding)))
    (if keymap
        (apply #'define-key keymap args)
      (apply #'global-set-key args))))

(provide 'smart-rebind)

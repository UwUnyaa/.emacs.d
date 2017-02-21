;;; smart-bind.el --- bind keys in all major modes

;;; Code:

(eval-when-compile
  (require 'cl))

(defvar smart-bind-key-list '()
  "List used internally by `smart-bind-key'. Do not modify it on
your own.")

;;;###autoload
(defun smart-bind-key (key function)
  "Binds KEY to FUNCTION in all major modes that redefine it.
KEY should be specified as a string."
  (setq key (kbd key))
  ;; set KEY to FUNCTION globally
  (global-set-key key function)
  (push (list (cons key function)) smart-bind-key-list)
  (add-hook 'after-change-major-mode-hook
            #'smart-bind-hook-function
            t))                         ; append

(defun smart-bind-hook-function ()
  "Internal function for `smart-bind-key' run on major mode change."
  (let ((current-map (current-local-map)))
    (when current-map
      (setq smart-bind-key-list
            (mapcar
             (lambda (set)
               (if (member major-mode (cdr set))
                   set
                 (define-key current-map (caar set) (cdar set))
                 `(,@set major-mode)))
             smart-bind-key-list)))))

(provide 'smart-bind)

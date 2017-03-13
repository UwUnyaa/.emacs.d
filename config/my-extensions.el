;;; this file contains configuration for extensions that don't come with GNU
;;; Emacs

(require 'cl)                   ; cl-remove-if-not

;; add ~/.emacs.d/lisp and every directory inside of it to load-path
(let ((dir (file-truename "~/.emacs.d/lisp")))
  (mapc (lambda (dir)
          (add-to-list 'load-path dir))
        (cons dir
              (cl-remove-if-not
               #'file-directory-p
               (directory-files-recursively dir "" t)))))

;;; `web-mode'
(setq web-mode-enable-auto-pairing t               ; auto-pairing
      web-mode-enable-css-colorization t           ; CSS colorization
      web-mode-enable-auto-expanding t             ; auto expanding
      web-mode-enable-current-element-highlight t ; highlight matching elements
      ;; custom indentation
      web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2)

;; file extensions
(mapc
 (lambda (extension)
   (add-to-list 'auto-mode-alist
                (cons (format "\\.%s\\'" extension)
                      'web-mode)))
 '("phtml" "tpl\\.php" "[agj]sp" "as[cp]x" "erb" "mustache" "djhtml" "html?"
   "css" "php" "twig"))

;; `ox-sfhp'
(require 'ox-sfhp)                ; code defining the backend isn't autoloaded

;;; `js2-mode'
(setq js2-strict-trailing-comma-warning nil ; ignores trailing commas
      js2-skip-preprocessor-directives t    ; ignores #!/bin/node
      js2-mode-assume-strict t
      js2-warn-about-unused-function-arguments t
      js2-global-externs '("setTimeout" "clearTimeout" "setInterval"
                           "clearInterval" "Promise"))

;; #!/bin/node turns on js2-mode with node context
(add-to-list 'interpreter-mode-alist '("node" . my-js2-node-mode))

;; file extensions
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(eval-after-load 'js2-mode
  (lambda ()
    ;; keybindings
    (define-key js2-mode-map (kbd "C-c C-n") #'js2-next-error)
    (define-key js2-mode-map (kbd "C-M-;") #'my-js2-comment-block)
    (define-key js2-mode-map (kbd "C-c C-u") #'my-js2-unicode-escape-region)))

(add-hook 'js2-mode-hook #'subword-mode)

(defvar my-js2-contexts-list
  '("browser" "node" "rhino")
  "A list of contexts for `my-js2-change-context'.

Each element of a list should corespond to a symbol that looks
like `js2-include-SYMBOL-externs'.")

;; define context modes
(mapc #'my-js2-define-context-mode my-js2-contexts-list)

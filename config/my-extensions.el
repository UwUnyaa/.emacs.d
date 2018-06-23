;;; this file contains configuration for extensions that don't come with GNU
;;; Emacs

(require 'cl)                   ; cl-remove-if-not

;; add ~/.emacs.d/lisp and every directory inside of it to load-path
(let ((dir (file-truename "~/.emacs.d/lisp")))
  (mapc
   (lambda (dir)
     (add-to-list 'load-path dir))
   (cons dir (cl-remove-if-not
              #'file-directory-p
              (directory-files-recursively dir "" t)))))

;;; `web-mode'
(setq web-mode-enable-auto-pairing t              ; auto-pairing
      web-mode-enable-css-colorization t          ; CSS colorization
      web-mode-enable-auto-expanding t            ; auto expanding
      web-mode-enable-current-element-highlight t ; highlight matching element
      ;; custom indentation
      web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2)

;; fix broken web-mode variables when emacs works as a daemon
(when (daemonp)
  (setq web-mode-enable-css-colorization t
        web-mode-enable-auto-indentation t
        web-mode-enable-auto-closing t
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-opening t
        web-mode-enable-auto-quoting t))

;; set up `web-mode-plus'
(eval-after-load 'web-mode
  (lambda ()
    (web-mode-plus-bind-keys)
    (web-mode-plus-set-html-snippets)))

;; file extensions
(mapc
 (lambda (extension)
   (add-to-list 'auto-mode-alist
                (cons (format "\\.%s\\'" extension)
                      'web-mode)))
 '("phtml" "tpl\\.php" "[agj]sp" "as[cp]x" "erb" "mustache" "djhtml" "php"
   "twig"))

;; use `my-web-skewer-html-mode' for HTML files
(add-to-list 'auto-mode-alist '("\\.html?\\'" . my-web-skewer-html-mode))

;;; `js2-mode'
(setq js2-strict-trailing-comma-warning nil ; ignores trailing commas
      js2-skip-preprocessor-directives t    ; ignores #!/bin/node
      js2-mode-assume-strict t
      js2-warn-about-unused-function-arguments t
      js2-global-externs '("setTimeout" "clearTimeout" "setInterval"
                           "clearInterval" "Promise" "fetch"))
;; JS2 indentation
(setq js-switch-indent-offset 2)

;; hook `skewer-mode' to `js2-mode'
(add-hook 'js2-mode-hook #'skewer-mode)

;; #!/bin/node turns on js2-mode with node context (and disables
;; `skewer-mode', because it has no use for node.js)
(add-to-list 'interpreter-mode-alist
             '("node" . (lambda ()
                          (my-js2-node-mode)
                          (when skewer-mode
                            (skewer-mode -1)))))

;; file extensions
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(eval-after-load 'js2-mode
  (lambda ()
    ;;; keybindings
    (define-key js2-mode-map (kbd "C-c C-n") #'js2-next-error)
    (define-key js2-mode-map (kbd "C-M-;") #'my-js2-comment-block)
    (define-key js2-mode-map (kbd "C-c C-u") #'my-js2-unicode-escape-region)))

(defvar my-js2-contexts-list
  '("browser" "node" "rhino")
  "A list of contexts for `my-js2-change-context'.

Each element of a list should corespond to a symbol that looks
like `js2-include-SYMBOL-externs'.")

;; define context modes
(mapc #'my-js2-define-context-mode my-js2-contexts-list)

;;; `yaml-mode'
(eval-after-load 'yaml-mode
  (lambda ()
    (define-key yaml-mode-map (kbd "RET") #'newline-and-indent)))

(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))

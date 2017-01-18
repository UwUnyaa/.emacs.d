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

;;; web-mode
;; select mode on filetype
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig\\'" . web-mode))
;; customize variables
(setq web-mode-enable-auto-pairing t               ; auto-pairing
      web-mode-enable-css-colorization t           ; CSS colorization
      web-mode-enable-auto-expanding t             ; auto expanding
      web-mode-enable-current-element-highlight t) ; highlight matching elements
(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-markup-indent-offset 2 ; custom indentation
                  web-mode-css-indent-offset 2
                  web-mode-code-indent-offset 2)))

;; ox-sfhp
(require 'ox-sfhp)                ; code defining the backend isn't autoloaded

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; #!/bin/node turns on js2-mode
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(setq js2-strict-trailing-comma-warning nil ; ignores trailing commas
      js2-skip-preprocessor-directives t)   ; ignores #!/bin/node
(add-hook 'js2-mode-hook
          (lambda ()
            (define-key js2-mode-map (kbd "C-c C-n") 'js2-next-error)
            (define-key js2-mode-map (kbd "C-M-;") 'my-js2-comment-block)
            (define-key js2-mode-map (kbd "C-c C-u")
              'my-js2-unicode-escape-region)
            (subword-mode)))

;; web-mode
(require 'web-mode)
;; select mode on filetype
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; auto-pairing
(setq web-mode-enable-auto-pairing t)
;; CSS colorization
(setq web-mode-enable-css-colorization t)
;; highlight matching HTML elements
(setq web-mode-enable-current-element-highlight t)

;; impatient-mode
;; dependencies
(require 'simple-httpd)
(require 'htmlize)
;; impatient-mode and its separate path (because it has a lot of files in it)
(add-to-list 'load-path "~/.emacs.d/lisp/impatient-mode/")
(require 'impatient-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8") ;UTF-8
 '(custom-enabled-themes (quote (wombat)))
 '(default-input-method "japanese")
 '(display-time-24hr-format t)		;display time in 24 hour format
 '(display-time-mode t)			;display time on modeline
 '(menu-bar-mode nil)			;no menu bar
 '(show-paren-mode t)			;highlight matching parens
 '(tool-bar-mode nil))

;; load-path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; no scroll-bar
(scroll-bar-mode 0)

;; blinking cursor
(blink-cursor-mode 1)

;; use C-h like readlne
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-?") 'help-command) ;new binding for help prefix

;; no sounds
(setq visible-bell nil)

;; no startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message "") ;empty scratch buffer

;; frame title if not started as a daemon
(setq frame-title-format "Emacs")

;; autosave every 60 seconds
(setq auto-save-timeout 60)

;; aliases
(defalias 'rs 'replace-string)

;; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;;; modes
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
;; indentation (2 spaces per level)
(defun my-web-mode-hook-indentation ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook-indentation)
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
;; a function to launch impatient-mode quicker
(defun my-impatient-mode()
  "A function that automatically enables impatient-mode along with httpd server if it isn't running."
  (interactive)
  (when (not (process-status "httpd"))
    (httpd-start))
  (impatient-mode))
(defalias 'im 'my-impatient-mode)	;M-x im 

;; daemon specific code
(when (daemonp)
  ;; load my erc autoconnect function (commented out)
  ;;(load-file "~/.emacs.d/config/myerc.el")
  ;; start erc automatically
  ;;(my-erc)
  
  ;; change the name of the frame
  (setq frame-title-format "Emacs (server)")

  ;; fix broken web-mode variables (will break emacsclient -t with pasting from clipboard)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-auto-indentation t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-opening t)
  (setq web-mode-enable-auto-quoting t))

;; disable warnings
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)

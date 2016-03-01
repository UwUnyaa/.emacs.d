(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (wombat)))
 '(default-input-method "japanese")
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(menu-bar-mode nil)
 '(org-startup-truncated nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

;; load-path
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; disable menu bar and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; no scroll-bar
(scroll-bar-mode 0)

;; blinking cursor
(blink-cursor-mode 1)

;; use C-h like readlne
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

;; no sounds
(setq visible-bell nil)

;; display time in mode line
(display-time-mode 1)

;; no startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message "") ;; empty scratch buffer

;; don't show line numbers on buffers
(global-linum-mode -1)

;; frame title
(setq frame-title-format "Emacs")

;; autosave every 60 seconds
(setq auto-save-timeout 60)

;; aliases
(defalias 'rs 'replace-string)

;; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)

;; show maching parens
(show-paren-mode 1)

;; modes

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
;; indentation
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
;; fix for auto tag closing on GNU+Linux
(setq web-mode-enable-auto-closing t)

;; impatient-mode
;; dependencies
(require 'simple-httpd)
(require 'htmlize)
;; impatient-mode and its separate path
(add-to-list 'load-path "~/.emacs.d/lisp/impatient-mode/")
(require 'impatient-mode)
;; a function to launch impatient-mode quicker
(defun my-impatient-mode()
  "A function that automatically enables impatient-mode along with httpd server."
  (interactive)
  (httpd-start)
  (impatient-mode))
(defalias 'im 'my-impatient-mode)	;alias for my function

;; daemon specific code
(when (daemonp)
  ;; load my erc autoconnect function
  (load-file "~/.emacs.d/config/myerc.el")
  (my-erc)
  ;; change the name of the frame
  (setq frame-title-format "Emacs (server)")
  )

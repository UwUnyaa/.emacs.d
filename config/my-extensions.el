;;; this file contains configuration for extensions that don't come with GNU
;;; Emacs

;;; `tide-mode'
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1))

(setq-default typescript-indent-level 2)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
;;; `web-mode'
(setq web-mode-enable-auto-pairing t              ; auto-pairing
      web-mode-enable-css-colorization t          ; CSS colorization
      web-mode-enable-auto-expanding t            ; auto expanding
      web-mode-enable-current-element-highlight t ; highlight matching element
      web-mode-links
      '(("\\.\\(png\\|jpe?g\\|gif\\|webp\\)$" "<img src=\"%s\" alt=\"\" />" nil 4)
        ("\\.svg$" "<object data=\"%s\" type=\"image/svg+xml\"></object>" nil 0)
        ("\\.js$" "<script type=\"text/javascript\" src=\"%s\"></script>" nil 0)
        ("\\.css$" "<link rel=\"stylesheet\" type=\"text/css\" href=\"%s\" />" t 0)
        ("\\.html?$" "<a href=\"%s\"></a>" nil 4))
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

(eval-after-load 'web-mode
  (lambda ()
    ;; set up `web-mode-plus'
    (web-mode-plus-bind-keys)
    (web-mode-plus-set-html-snippets)
    ;; bind HTML hierarchy motion
    (define-key web-mode-map (kbd "C-M-u") #'web-mode-element-parent)
    (define-key web-mode-map (kbd "C-M-d") #'web-mode-element-child)
    (define-key web-mode-map (kbd "C-M-n") #'web-mode-element-next)
    (define-key web-mode-map (kbd "C-M-p") #'web-mode-element-previous)))

;; file extensions
(mapc
 (lambda (extension)
   (add-to-list 'auto-mode-alist
                (cons (format "\\.%s\\'" extension)
                      'web-mode)))
 '("html" "tpl\\.php" "[agj]sp" "as[cp]x" "erb" "mustache" "djhtml" "twig"
   "phtml" "tsx"))

;; `tide-mode' setup for TSX
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(require 'flycheck)
(flycheck-add-mode 'typescript-tslint 'web-mode)

;;; `js2-mode'
(setq js2-strict-trailing-comma-warning nil ; ignores trailing commas
      js2-skip-preprocessor-directives t    ; ignores #!/bin/node
      js2-mode-assume-strict t
      js2-warn-about-unused-function-arguments t
      js2-global-externs '("setTimeout" "clearTimeout" "setInterval"
                           "clearInterval" "Promise" "fetch" "URL"))
;; JS2 indentation
(setq js-switch-indent-offset 2)

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

;; #!/bin/node turns on js2-mode with node context
(add-to-list 'interpreter-mode-alist
             '("node" . (lambda ()
                          (my-js2-node-mode))))

;;; `yaml-mode'
(eval-after-load 'yaml-mode
  (lambda ()
    (define-key yaml-mode-map (kbd "RET") #'newline-and-indent)))

(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))

;;; `yasnippet'
(setq yas-alias-to-yas/prefix-p nil)
(eval-after-load 'yasnippet
  (lambda ()
    ;; load snippets (neccesary when using only the minor mode)
    (yas-reload-all)
    (setq yas-also-indent-empty-lines t
          yas-also-auto-indent-first-line t
          ;; prevent expanding snippets in comments and fall back to default
          ;; command when needed:
          ;; https://emacs.stackexchange.com/a/46776/12563
          yas-buffer-local-condition yas-not-string-or-comment-condition
          yas-fallback-behavior 'call-other-command)

    ;; minor mode keys
    ;; unbind TAB
    (define-key yas-minor-mode-map (kbd "<tab>") nil)
    (define-key yas-minor-mode-map (kbd "TAB") nil)
    ;; Bind `SPC' to `yas-maybe-expand' when snippet expansion available (it
    ;; will still call `self-insert-command' otherwise).
    (define-key yas-minor-mode-map (kbd "SPC") yas-maybe-expand)
    ;; Bind `C-c y' to `yas-expand' ONLY.
    (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)

    ;; keys for snippet edition
    (define-key yas-keymap (kbd "RET") #'yas-next-field-or-maybe-expand)

    (add-hook 'yas-after-exit-snippet-hook
              (lambda ()
                ;; dynamic scoping ugliness ahead, beware
                (indent-region yas-snippet-beg yas-snippet-end)
                (indent-for-tab-command)))))

;; enable `yas-minor-mode' in given major modes
(mapc
 (lambda (hook)
   (add-hook (intern (format "%s-hook" hook)) #'yas-minor-mode))
 '(js-mode))

;;; `graphql-mode'
(add-to-list 'auto-mode-alist '("\\.gql\\'" . graphql-mode))

;;; `org-mode' export backends
;; `ox-reveal'
(setq org-reveal-root
      "https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.7.0/")

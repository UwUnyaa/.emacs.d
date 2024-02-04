;;; this file contains configuration for extensions that don't come with GNU
;;; Emacs

;;; `exec-path-from-shell'
(when (or (memq window-system '(mac ns x pgtk)) (daemonp))
  (exec-path-from-shell-initialize))

;;; `smartparens'
(require 'smartparens-config)
(smartparens-global-mode)
(show-smartparens-global-mode)

(setq sp-highlight-pair-overlay nil     ; disable highlighting
      sp-highlight-wrap-overlay nil
      sp-highlight-wrap-tag-overlay nil
      ;; permit using smartparens in minibuffers
      sp-ignore-modes-list '(minibuffer-inactive-mode))

;; use smartparens in `eval-expression'
(add-hook 'eval-expression-minibuffer-setup-hook
          (lambda ()
            (smartparens-mode t)))

;; add extra newlines and indent {}
(sp-pair "{" "}" :post-handlers '(("||\n[i]" "RET")))

;; `typescript-ts-mode'
(sp-local-pair 'typescript-ts-mode "<" ">" :actions '(wrap))

;; `minibuffer-mode'
(sp-local-pair 'minibuffer-mode "'" "'" :actions nil)

;;; `tide-mode'
(add-hook 'typescript-ts-mode-hook #'my-setup-tide-mode)
(add-hook 'tsx-ts-mode #'my-setup-tide-mode)

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

(with-eval-after-load 'web-mode
  ;; remove pair that conflicts with `electric-pair-mode' for vue templates
  (setf (alist-get "vue" web-mode-engines-auto-pairs) '())
  ;; set up `web-mode-plus'
  (web-mode-plus-bind-keys)
  (web-mode-plus-set-html-snippets)
  ;; bind HTML hierarchy motion
  (define-key web-mode-map (kbd "C-M-u") #'web-mode-element-parent)
  (define-key web-mode-map (kbd "C-M-d") #'web-mode-element-child)
  (define-key web-mode-map (kbd "C-M-n") #'web-mode-element-next)
  (define-key web-mode-map (kbd "C-M-p") #'web-mode-element-previous))

;; file extensions
(mapc
 (lambda (extension)
   (add-to-list 'auto-mode-alist
                (cons (format "\\.%s\\'" extension)
                      'web-mode)))
 '("html" "tpl\\.php" "[agj]sp" "as[cp]x" "erb" "mustache" "djhtml" "twig"
   "phtml" "vue"))

;; hack `company' to provide a CAPF in `tide'
(require 'company)
(with-eval-after-load 'tide
  (defalias 'my-company-tide-capf (cape-company-to-capf #'company-tide)))

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
(add-to-list 'auto-mode-alist '("\\.m?js\\'" . js2-mode))

(with-eval-after-load 'js2-mode
;;; keybindings
  (define-key js2-mode-map (kbd "C-c C-n") #'js2-next-error)
  (define-key js2-mode-map (kbd "C-c C-u") #'my-js2-unicode-escape-region))

;; set up globals for jest and cypress test files
(add-hook 'js2-mode-hook
          (lambda ()
            (when (and (buffer-file-name)
                       (string-match
                        "\\.\\(test\\|spec\\|cy\\)\\.js$"
                        (buffer-file-name)))
              (make-local-variable 'js2-global-externs)
              (mapc
               (lambda (global)
                 (push global js2-global-externs))
               '("afterAll" "after" "before" "beforeAll" "beforeEach" "describe"
                 "expect" "it" "jest" "test")))))

;; add cy to cypress variables
(add-hook 'js2-mode-hook
          (lambda ()
            (when (and (buffer-file-name)
                       (string-match
                        "\\.cy\\.js$"
                        (buffer-file-name)))
              (make-local-variable 'js2-global-externs)
              (push "cy" js2-global-externs))))

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
(with-eval-after-load 'yaml-mode
  (define-key yaml-mode-map (kbd "RET") #'newline-and-indent))

(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))

;;; `yasnippet'
(setq yas-alias-to-yas/prefix-p nil)
(with-eval-after-load 'yasnippet
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
              (indent-for-tab-command))))

;; enable `yas-minor-mode' in given major modes
(mapc
 (lambda (hook)
   (add-hook (intern (format "%s-hook" hook)) #'yas-minor-mode))
 '(js-mode typescript-ts-mode))

;;; `org-mode' export backends
;; `ox-reveal'
(setq org-reveal-root
      "https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.7.0/")

;;; `ob-restclient'
(with-eval-after-load 'org-mode
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((restclient . t))))

;;; `dotenv-mode'
(add-to-list 'auto-mode-alist '("\\.env\\..*\\'" . dotenv-mode))

;;; `csv-mode'
(setq csv-invisibility-default nil)
;; monkey patch a basic type error, GNU elpa sucks and there's no proper bug
;; tracker
(add-hook 'csv-mode-hook
          (lambda ()
            (setq-local buffer-invisibility-spec nil)))

;;; `dimmer'
(require 'dimmer)
(dimmer-mode +1)

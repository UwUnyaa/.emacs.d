;;; autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "d-mode" "d-mode.el" (22912 23242 256011 495000))
;;; Generated autoloads from d-mode.el
 (add-to-list 'auto-mode-alist '("\\.d[i]?\\'" . d-mode))

(defvar d-mode-hook nil "\
*Hook called by `d-mode'.")

(custom-autoload 'd-mode-hook "d-mode" t)

(autoload 'd-mode "d-mode" "\
Major mode for editing code written in the D Programming Language.

See http://dlang.org for more information about the D language.

The hook `c-mode-common-hook' is run with no args at mode
initialization, then `d-mode-hook'.

Key bindings:
\\{d-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads nil "htmlize" "htmlize.el" (22912 23242 259344
;;;;;;  827000))
;;; Generated autoloads from htmlize.el

(autoload 'htmlize-buffer "htmlize" "\
Convert BUFFER to HTML, preserving colors and decorations.

The generated HTML is available in a new buffer, which is returned.
When invoked interactively, the new buffer is selected in the current
window.  The title of the generated document will be set to the buffer's
file name or, if that's not available, to the buffer's name.

Note that htmlize doesn't fontify your buffers, it only uses the
decorations that are already present.  If you don't set up font-lock or
something else to fontify your buffers, the resulting HTML will be
plain.  Likewise, if you don't like the choice of colors, fix the mode
that created them, or simply alter the faces it uses.

\(fn &optional BUFFER)" t nil)

(autoload 'htmlize-region "htmlize" "\
Convert the region to HTML, preserving colors and decorations.
See `htmlize-buffer' for details.

\(fn BEG END)" t nil)

(autoload 'htmlize-file "htmlize" "\
Load FILE, fontify it, convert it to HTML, and save the result.

Contents of FILE are inserted into a temporary buffer, whose major mode
is set with `normal-mode' as appropriate for the file type.  The buffer
is subsequently fontified with `font-lock' and converted to HTML.  Note
that, unlike `htmlize-buffer', this function explicitly turns on
font-lock.  If a form of highlighting other than font-lock is desired,
please use `htmlize-buffer' directly on buffers so highlighted.

Buffers currently visiting FILE are unaffected by this function.  The
function does not change current buffer or move the point.

If TARGET is specified and names a directory, the resulting file will be
saved there instead of to FILE's directory.  If TARGET is specified and
does not name a directory, it will be used as output file name.

\(fn FILE &optional TARGET)" t nil)

(autoload 'htmlize-many-files "htmlize" "\
Convert FILES to HTML and save the corresponding HTML versions.

FILES should be a list of file names to convert.  This function calls
`htmlize-file' on each file; see that function for details.  When
invoked interactively, you are prompted for a list of files to convert,
terminated with RET.

If TARGET-DIRECTORY is specified, the HTML files will be saved to that
directory.  Normally, each HTML file is saved to the directory of the
corresponding source file.

\(fn FILES &optional TARGET-DIRECTORY)" t nil)

(autoload 'htmlize-many-files-dired "htmlize" "\
HTMLize dired-marked files.

\(fn ARG &optional TARGET-DIRECTORY)" t nil)

;;;***

;;;### (autoloads nil "json-mode" "json-mode.el" (23098 25530 436672
;;;;;;  87000))
;;; Generated autoloads from json-mode.el

(autoload 'json-mode "json-mode" "\
A simple mode for JSON editing.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

;;;***

;;;### (autoloads nil "ox-sfhp" "ox-sfhp.el" (23098 15020 564588
;;;;;;  956000))
;;; Generated autoloads from ox-sfhp.el

(autoload 'org-sfhp-export-to-buffer "ox-sfhp" "\
Export current buffer to a single file HTML presentation buffer.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-sfhp-export-to-file "ox-sfhp" "\
Export current buffer to a single file HTML presentation file.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-sfhp-export-to-file-and-open "ox-sfhp" "\
Export current buffer to a single file HTML presentation file
and open it.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

;;;***

;;;### (autoloads nil "simple-httpd" "simple-httpd.el" (22912 23242
;;;;;;  272678 161000))
;;; Generated autoloads from simple-httpd.el

(autoload 'httpd-start "simple-httpd" "\
Start the web server process. If the server is already
running, this will restart the server. There is only one server
instance per Emacs instance.

\(fn)" t nil)

(autoload 'httpd-stop "simple-httpd" "\
Stop the web server if it is currently running, otherwise do nothing.

\(fn)" t nil)

(autoload 'httpd-serve-directory "simple-httpd" "\
Start the web server with given `directory' as `httpd-root'.

\(fn DIRECTORY)" t nil)

;;;***

;;;### (autoloads nil "web-mode" "web-mode.el" (23168 12757 45099
;;;;;;  733000))
;;; Generated autoloads from web-mode.el

(web-mode-define-derived-mode web-mode "Web" "Major mode for editing web templates." (make-local-variable 'web-mode-attr-indent-offset) (make-local-variable 'web-mode-attr-value-indent-offset) (make-local-variable 'web-mode-auto-pairs) (make-local-variable 'web-mode-block-regexp) (make-local-variable 'web-mode-change-beg) (make-local-variable 'web-mode-change-end) (make-local-variable 'web-mode-code-indent-offset) (make-local-variable 'web-mode-column-overlays) (make-local-variable 'web-mode-comment-formats) (make-local-variable 'web-mode-comment-style) (make-local-variable 'web-mode-content-type) (make-local-variable 'web-mode-css-indent-offset) (make-local-variable 'web-mode-display-table) (make-local-variable 'web-mode-django-control-blocks) (make-local-variable 'web-mode-django-control-blocks-regexp) (make-local-variable 'web-mode-enable-block-face) (make-local-variable 'web-mode-enable-inlays) (make-local-variable 'web-mode-enable-part-face) (make-local-variable 'web-mode-enable-sexp-functions) (make-local-variable 'web-mode-engine) (make-local-variable 'web-mode-engine-attr-regexp) (make-local-variable 'web-mode-engine-file-regexps) (make-local-variable 'web-mode-engine-open-delimiter-regexps) (make-local-variable 'web-mode-engine-token-regexp) (make-local-variable 'web-mode-expand-initial-pos) (make-local-variable 'web-mode-expand-initial-scroll) (make-local-variable 'web-mode-expand-previous-state) (make-local-variable 'web-mode-indent-style) (make-local-variable 'web-mode-indentless-attributes) (make-local-variable 'web-mode-indentless-elements) (make-local-variable 'web-mode-inhibit-fontification) (make-local-variable 'web-mode-is-scratch) (make-local-variable 'web-mode-jshint-errors) (make-local-variable 'web-mode-last-enabled-feature) (make-local-variable 'web-mode-markup-indent-offset) (make-local-variable 'web-mode-minor-engine) (make-local-variable 'web-mode-overlay-tag-end) (make-local-variable 'web-mode-overlay-tag-start) (make-local-variable 'web-mode-part-beg) (make-local-variable 'web-mode-scan-beg) (make-local-variable 'web-mode-scan-end) (make-local-variable 'web-mode-sql-indent-offset) (make-local-variable 'web-mode-time) (make-local-variable 'comment-end) (make-local-variable 'comment-region-function) (make-local-variable 'comment-start) (make-local-variable 'fill-paragraph-function) (make-local-variable 'font-lock-beg) (make-local-variable 'font-lock-defaults) (make-local-variable 'font-lock-extend-region-functions) (make-local-variable 'font-lock-end) (make-local-variable 'font-lock-support-mode) (make-local-variable 'font-lock-unfontify-region-function) (make-local-variable 'imenu-case-fold-search) (make-local-variable 'imenu-create-index-function) (make-local-variable 'imenu-generic-expression) (make-local-variable 'indent-line-function) (make-local-variable 'parse-sexp-lookup-properties) (make-local-variable 'uncomment-region-function) (make-local-variable 'yank-excluded-properties) (setq web-mode-time (current-time)) (setq comment-end "-->" comment-region-function 'web-mode-comment-or-uncomment-region comment-start "<!--" fill-paragraph-function 'web-mode-fill-paragraph font-lock-defaults '(web-mode-font-lock-keywords t) font-lock-extend-region-functions '(web-mode-extend-region) font-lock-support-mode nil font-lock-unfontify-region-function 'web-mode-unfontify-region imenu-case-fold-search t imenu-create-index-function 'web-mode-imenu-index indent-line-function 'web-mode-indent-line parse-sexp-lookup-properties t yank-excluded-properties t uncomment-region-function 'web-mode-comment-or-uncomment-region) (substitute-key-definition 'indent-new-comment-line 'web-mode-comment-indent-new-line web-mode-map global-map) (add-hook 'after-change-functions 'web-mode-on-after-change nil t) (add-hook 'after-save-hook 'web-mode-on-after-save t t) (add-hook 'change-major-mode-hook 'web-mode-on-exit nil t) (add-hook 'post-command-hook 'web-mode-on-post-command nil t) (cond ((boundp 'yas-after-exit-snippet-hook) (add-hook 'yas-after-exit-snippet-hook 'web-mode-yasnippet-exit-hook t t)) ((boundp 'yas/after-exit-snippet-hook) (add-hook 'yas/after-exit-snippet-hook 'web-mode-yasnippet-exit-hook t t))) (when web-mode-enable-whitespace-fontification (web-mode-whitespaces-on)) (when web-mode-enable-sexp-functions (setq-local forward-sexp-function 'web-mode-forward-sexp)) (web-mode-guess-engine-and-content-type) (setq web-mode-change-beg (point-min) web-mode-change-end (point-max)) (when (> (point-max) 256000) (web-mode-buffer-highlight)) (when (and (boundp 'hs-special-modes-alist) (not (assoc major-mode hs-special-modes-alist))) (add-to-list 'hs-special-modes-alist '(web-mode "{" "}" "/[*/]" web-mode-forward-sexp nil))))

;;;***

;;;### (autoloads nil "web-mode-plus" "web-mode-plus.el" (23098 25304
;;;;;;  86671 312000))
;;; Generated autoloads from web-mode-plus.el

(autoload 'web-mode-plus-bind-keys "web-mode-plus" "\
Set default keybindings for `web-mode-plus'.
This function should be run after `web-mode' is loaded.

\(fn)" t nil)

(autoload 'web-mode-plus-set-html-snippets "web-mode-plus" "\
Replace HTML snippets with ones optimized for `web-mode-plus'.

\(fn)" nil nil)

;;;***

(provide 'autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; autoloads.el ends here

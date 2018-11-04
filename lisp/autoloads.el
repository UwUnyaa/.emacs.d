;;; autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "d-mode" "d-mode.el" (0 0 0 0))
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

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "d-mode" '("doxygen-font-lock-" "d-")))

;;;***

;;;### (autoloads nil "glsl-mode" "glsl-mode.el" (0 0 0 0))
;;; Generated autoloads from glsl-mode.el

(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))

(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))

(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))

(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))

(autoload 'glsl-mode "glsl-mode" "\
Major mode for editing OpenGLSL shader files.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "glsl-mode" '(#("gl-version" 0 2 (fontified nil face font-lock-function-name-face) 2 10 (fontified nil face font-lock-variable-name-face)) #("glsl-" 0 2 (fontified nil face font-lock-function-name-face) 2 5 (fontified nil face font-lock-function-name-face)))))

;;;***

;;;### (autoloads nil "htmlize" "htmlize.el" (0 0 0 0))
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

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "htmlize" '("htmlize-")))

;;;***

;;;### (autoloads nil "json-mode" "json-mode.el" (0 0 0 0))
;;; Generated autoloads from json-mode.el

(autoload 'json-mode "json-mode" "\
A simple mode for JSON editing.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "json-mode" '("json-mode-")))

;;;***

;;;### (autoloads nil "ox-sfhp" "ox-sfhp.el" (0 0 0 0))
;;; Generated autoloads from ox-sfhp.el

(autoload 'org-sfhp-export-to-buffer "ox-sfhp" "\
Export current buffer to a single file HTML presentation buffer.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-sfhp-export-to-file "ox-sfhp" "\
Export current buffer to a single file HTML presentation file.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(autoload 'org-sfhp-export-to-file-and-open "ox-sfhp" "\
Export current buffer with `ox-sfhp' and open it.

\(fn &optional ASYNC SUBTREEP VISIBLE-ONLY BODY-ONLY EXT-PLIST)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ox-sfhp" '("org-sfhp-")))

;;;***

;;;### (autoloads nil "simple-httpd" "simple-httpd.el" (0 0 0 0))
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

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "simple-httpd" '("httpd" "defservlet" "with-httpd-buffer")))

;;;***

;;;### (autoloads nil "web-mode" "web-mode.el" (0 0 0 0))
;;; Generated autoloads from web-mode.el

(autoload 'web-mode "web-mode" "\
Major mode for editing web templates.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "web-mode" '("web-mode-")))

;;;***

;;;### (autoloads nil "web-mode-plus" "web-mode-plus.el" (0 0 0 0))
;;; Generated autoloads from web-mode-plus.el

(autoload 'web-mode-plus-bind-keys "web-mode-plus" "\
Set default keybindings for `web-mode-plus'.
This function should be run after `web-mode' is loaded.

\(fn)" t nil)

(autoload 'web-mode-plus-set-html-snippets "web-mode-plus" "\
Replace HTML snippets with ones optimized for `web-mode-plus'.

\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "web-mode-plus" '("web-mode-plus-")))

;;;***

;;;### (autoloads nil "yaml-mode" "yaml-mode.el" (0 0 0 0))
;;; Generated autoloads from yaml-mode.el

(let ((loads (get 'yaml 'custom-loads))) (if (member '"yaml-mode" loads) nil (put 'yaml 'custom-loads (cons '"yaml-mode" loads))))

(autoload 'yaml-mode "yaml-mode" "\
Simple mode to edit YAML.

\\{yaml-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.\\(e?ya?\\|ra\\)ml\\'" . yaml-mode))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "yaml-mode" '("yaml-")))

;;;***

(provide 'autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; autoloads.el ends here

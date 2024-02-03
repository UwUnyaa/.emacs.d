;;; straight.el configuration
(setq straight-cache-autoloads t)

(defun my-straight-require-from-github (repo-info)
  "Use a package from github described by REPO-INFO.

REPO-INFO must be a list, which should contain the name of the
repository in question, and optionally the package name, which
should map to the matching feature in it."
  (let* ((repo-name (car repo-info))
          (package-name (or (cadr repo-info)
                            (intern (cadr (split-string repo-name "/"))))))
     (straight-use-package
      `(,package-name :type git :host github :repo ,repo-name))))

;; require all packages via straight.el
(mapc
 #'my-straight-require-from-github
 '(("joaotavora/yasnippet")
   ("gonewest818/dimmer.el" dimmer)
   ("hniksic/emacs-htmlize" htmlize)
   ("company-mode/company-mode" company)
   ("minad/cape")
   ("Fuco1/smartparens")
   ("magit/magit")
   ("UwUnyaa/presentation-mode")
   ("UwUnyaa/ox-reveal")
   ("skeeto/emacs-http-server" simple-httpd)
   ("UwUnyaa/ox-sfhp")
   ("ledger/ledger-mode")
   ("mooz/js2-mode")
   ("felipeochoa/rjsx-mode")
   ("ananthakumaran/tide")
   ("emacs-php/php-mode")
   ("rust-lang/rust-mode")
   ("Emacs-D-Mode-Maintainers/Emacs-D-Mode" d-mode)
   ("fxbois/web-mode")
   ("UwUnyaa/web-mode-plus")
   ("UwUnyaa/json-mode")
   ("spotify/dockerfile-mode")
   ("yoshiki/yaml-mode")
   ("jrblevin/markdown-mode")
   ("Fanael/edit-indirect")
   ("purcell/exec-path-from-shell")
   ("haskell/haskell-mode")
   ("preetpalS/emacs-dotenv-mode" dotenv-mode)
   ("emacsorphanage/haxe-mode")))

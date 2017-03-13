;; daemon specific code
(when (daemonp)
  (setq frame-title-format "Emacs (server)" ; name of the daemon frame
        ;; fix broken web-mode variables (won't work in emacsclient -t when
        ;; pasting from clipboard)
        web-mode-enable-css-colorization t
        web-mode-enable-auto-indentation t
        web-mode-enable-auto-closing t
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-opening t
        web-mode-enable-auto-quoting t))

;; try configuring fonts
(when (and (display-graphic-p)
           (member "DejaVu Sans Mono" (font-family-list)))
  (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9")))

;; use human readable file sizes in dired if they'll work
(when (or (member system-type '(ms-dos windows-nt))    ; ls in elisp
          (eq 0 (call-process insert-directory-program ; check if ls -h works
                              nil nil nil "-h")))
  (setq dired-listing-switches (concat dired-listing-switches "h")))

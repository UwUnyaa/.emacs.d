;; daemon specific code
(when (daemonp)
  (setq frame-title-format "Emacs (server)")) ; name of the daemon frame

;; try configuring fonts
(when (and (display-graphic-p)
           (member "DejaVu Sans Mono" (font-family-list)))
  (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9")))

;; use human readable file sizes in dired if they'll work
(when (or (member system-type '(ms-dos windows-nt))    ; ls in elisp
          (eq 0 (call-process insert-directory-program ; check if ls -h works
                              nil nil nil "-h")))
  (setq dired-listing-switches (concat dired-listing-switches "h")))

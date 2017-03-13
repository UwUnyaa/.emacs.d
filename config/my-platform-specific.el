;; daemon specific code
(when (daemonp)
  (setq frame-title-format "Emacs (server)")) ; name of the daemon frame

;; try configuring fonts
(when (and (display-graphic-p)
           (member "DejaVu Sans Mono" (font-family-list)))
  (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9")))

;; I don't want this config to default to being on, so I'm gating it behind a
;; variable meant to be set from my-local.el

(defcustom my-ai-enable nil
  "Knob to enable AI integration."
  :type 'boolean)

;; install packages
(when my-ai-enable
  (mapc
   #'my-straight-require-from-github
   '(("copilot-emacs/copilot.el" copilot)
     ("tninja/ai-code-interface.el" ai-code)
     ("akermu/emacs-libvterm" vterm)))) ; dependency of ai-mode

;;; `copilot' configuation
(when my-ai-enable
  (require 'copilot)
  (require 'copilot-nes)

  ;; `copilot-mode' customization
  (keymap-set copilot-completion-map "M-<tab>" #'copilot-accept-completion)
  (keymap-set copilot-completion-map "M-n" #'copilot-next-completion)
  (keymap-set copilot-completion-map "M-p" #'copilot-previous-completion)
  (add-hook 'prog-mode-hook #'copilot-mode)

  ;; `copilot-nes' customization
  (add-hook 'prog-mode-hook #'copilot-nes-mode))

;;; `ai-code' configuration
(when my-ai-enable
  (require 'ai-code)
  (ai-code-set-backend 'github-copilot-cli)
  (global-set-key (kbd "C-c a") #'ai-code-menu))

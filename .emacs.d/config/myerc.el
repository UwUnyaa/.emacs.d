(require 'erc-services)
(erc-services-mode 1)
(setq erc-nick "nick")			; nick
(setq erc-autojoin-channels-alist    ; autojoin
      '(("irc.uworld.se" "#examplechannel1" "#examplechannel2")))
;; depending on the server you want to connect you might need to use an adress of one of the subservers for this to work (one of the Rizon subservers is in this example)
(setq erc-prompt-for-nickserv-password nil) ; nickserv
(setq erc-nickserv-passwords
      '((rizon     (("nick" . "password"))))) ; your nickserv password (you can store this in a different file)

(defun my-erc ()
  "My function to connect to irc"
  (interactive)
  (erc :server "irc.uworld.se" :port 6667) ; connect to server
  (erc-nickserv-identify "password")	   ; I use this command to identify instead
  )

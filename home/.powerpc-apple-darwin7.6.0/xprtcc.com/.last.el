;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.powerpc-apple-darwin7.6.0/xprtcc.com/.last.el#1 $
;;

;;  
;; Last set value means that this was the last value when 
;; emacs was acting as the smtp server
;;

;;
;; Filter using tmda
;;

(setq sendmail-program "/usr/bin/tmda-sendmail")

;;(setq send-mail-function 'smtpmail-send-it) ; Last set value 

;;(setq smtpmail-default-smtp-server "mail.swbell.net")  ; Last set value
;;
;; Old versions of smtpmail-default-smtp-server
;;
;; (setq smtpmail-default-smtp-server "mail.infohwy.com")

;;(setq smtpmail-smtp-service "smtp") ; Last set value 
;;
;; Old versions of smtpmail-smtp-service
;;
;; (setq smtpmail-local-domain "luthersem.edu")
;; (setq smtpmail-local-domain "swbell.net")
;; (setq smtpmail-local-domain "infohwy.com")

;;(setq smtpmail-debug-info nil) ; Last set value 
;;(load-library "smtpmail") ; Last set value 
;;(setq smtpmail-code-conv-from nil) ; Last set value 

(setq user-full-name "Jody Winston")

;; if you are in the white list use
;; (setq user-mail-address "josephwinston@mac.com")
;; else use
(setq user-mail-address "jody@adsl-216-62-149-210.dsl.hstntx.swbell.net")

;;
;; Old versions of user-mail-address
;;
;;(setq user-mail-address "jwinston@luthersem.edu")
;;(setq user-mail-address "jwinston@infohwy.com")
;;(setq user-mail-address "jody@sccsi.com")

(setq mail-archive-file-name (expand-file-name "~/mail/outgoing"))

;;
;; Start the server
;;

(if (or running-xemacs20 running-xemacs21)
    (gnuserv-start)
  (server-start))

;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.i686-unknown-linux/xprtcc.com/.last.el#8 $
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
(setq user-mail-address "josephwinston@mac.com")

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

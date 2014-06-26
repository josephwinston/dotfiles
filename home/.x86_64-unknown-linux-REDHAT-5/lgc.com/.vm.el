;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.i686-unknown-linux/xprtcc.com/.vm.el#11 $
;;

;;
;; List of applications to be used to display mime messages
;; Can use either acroread or xpdf
;;

(setq vm-mime-external-content-types-alist 
      '(("text/html" "netscape") 
	("image/gif" "ee") 
	("image/jpeg" "ee") 
	("application/postscript" "ghostview") 
	("application/x-dvi" "xdvi") 
	("application/pdf" "acroread") 
	("application/ms-tnef" "tnef")
;	("application/msword" "soffice") ; Note soffice is not installed
	))

;; (setq vm-auto-get-new-mail nil)
;; (setq vm-mail-check-interval nil)

(setq vm-primary-inbox "~/mail/INBOX")

(setq vm-spool-files
      '(
	("~/mail/SCCSI" 
	 "mail.infohwy.com:110:pass:jwinston:*" 
	 "~/mail/CRASHBOX/SCCSI")
	("~/mail/MAC" 
	 "mail.mac.com:110:pass:josephwinston:*" 
	 "~/mail/CRASHBOX/MAC")
	("~/mail/ALLYALL" 
	 "postoffice.swbell.net:110:pass:allyall:*" 
	 "~/mail/CRASHBOX/ALLYALL")
	("~/mail/LUTHER" 
	 "imap:pop3.luthersem.edu:143:inbox:login:jwinston:*" 
	 "~/mail/CRASHBOX/LUTHER")
	("~/mail/INBOX" 
	 "/var/spool/mail/jody" 
	 "~/mail/CRASHBOX/INBOX")
	)
      )
;;
;; Remove mail from here
;;

(setq vm-pop-auto-expunge-alist
      '(
	;; Remove the messages
	("mail.infohwy.com:110:pass:jwinston:*" . t)  
	;; Remove the messages
	("mail.mac.com:110:pass:josephwinston:*" . t)  
	;; Remove the messages
	("postoffice.swbell.net:110:pass:allyall:*" . t)  
	)
      )

(setq vm-imap-auto-expunge-alist
      '(
	;; expunge immediately
	("imap:pop3.luthersem.edu:143:inbox:login:jwinston:*" . t)
))

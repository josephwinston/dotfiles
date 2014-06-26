;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.powerpc-apple-darwin7.9.0/xprtcc.com/.gnus.el#1 $
;;

;;
;; Gnus currently fetches using two connections articles, but this
;; fails with Bell's NNTP setup, so turn this option off.
;;

;(defun message-make-sender()
;  "return the \"real\" sender"
;  "josephwinston@mac.com")

(setq gnus-asynchronous nil)

(setq gnus-local-organization "xprt Computer Consulting, Inc.")

;;
;; No username or password on this server (But real slow now)
;;
;; (setq gnus-nntp-server "news.sbcglobal.net")

;;
;; On the following servers the username is allyall@swbell.net
;;

(setq gnus-nntp-server "news.houston.sbcglobal.net")
;; (setq gnus-nntp-server "news.dallas.sbcglobal.net")

;;
;; Picons
;;

;(setq gnus-use-picons t)
;(setq gnus-treat-display-picons t)
;(setq gnus-picons-piconsearch-url 
;      "http://www.cs.indiana.edu/picons/search.html")

;;
;; email using tmda
;;

;(defun tmda-dated-address () 
;  (shell-command-to-string "/usr/bin/tmda-dated-address"))
 
;(setq gnus-posting-styles 
;      '((message-news-p)
;	(address tmda-dated-address)
;	))



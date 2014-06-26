;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.sparc-sun-sunos4.1.3_U1/xprt.com/.info.el#1 $
;;

(require 'info)

;;
;; find local info nodes
;;

(setq Info-directory-list
      (append Info-directory-list '("/usr/local/info/")))

;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.powerpc-ibm-aix4.2.0.0/hls_ts/.info.el#1 $
;;

(require 'info)

;;
;; find local info nodes
;;

(setq Info-directory-list
      (append Info-directory-list '("/usr/local/info/")))

(setq Info-directory-list
      (append Info-directory-list '("/home/jody/Tools/info")))

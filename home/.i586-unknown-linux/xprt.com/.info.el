;; -*- Emacs-Lisp -*-

;;
;; $Id: .info.el,v 1.1 2000/09/05 00:24:12 CVS_jody Exp $
;;

(require 'info)

;;
;; find local info nodes
;;

(setq Info-directory-list
      (append Info-directory-list '("/home/jody/Tools/info")))

(setq Info-directory-list
      (append Info-directory-list '("/usr/aag/teTeX/info")))

(setq Info-directory-list
      (append Info-directory-list '("/usr/aag/info")))


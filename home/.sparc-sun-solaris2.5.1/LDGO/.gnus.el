;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.sparc-sun-solaris2.5.1/LDGO/.gnus.el#1 $
;;

(autoload 'gnus "gnus" "Read network news." t)
(autoload 'gnus-post-news "gnus" "Post a news." t)

(setq gnus-select-method '(nntp "news.ldgo.columbia.edu"))

(setq gnus-local-organization "Lamont-Doherty Earth Observatory")
(setq gnus-asynchronous t)



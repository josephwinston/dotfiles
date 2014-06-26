;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.powerpc-apple-darwin7.9.0/xprtcc.com/.emacs.21.el#1 $
;;

;;
;; Set up bbdb
;;

;; (require 'bbdb)
;; (bbdb-initialize 'gnus 'message 'sc 'w3 'vm)

;;
;; Set up auctex
;;

;;
;; Enable parsing
;;

(setq TeX-auto-save t)			; Enable parse on load.
(setq TeX-parse-self t)			; Enable parse on save.
(setq-default TeX-master nil)

;;
;; Maximum decoration
;;

(setq font-lock-maximum-decoration t) 

;;
;; Add reftex
;;

(autoload 'turn-on-reftex "reftex")
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode

;;
;; Add bib-cite
;;

;; (autoload 'turn-on-bib-cite "bib-cite")
;; (add-hook 'LaTeX-mode-hook 'turn-on-bib-cite)
;; (add-hook 'latex-mode-hook 'turn-on-bib-cite)

;;
;; Adjust the default directory
;;

(if (equal default-directory "/") 
    (setq default-directory "~/")
  )
 
;;
;; Help the compiler parsing
;;

(setq process-connection-type nil)

;;
;; spellingx
;;

(setq ispell-program-name "/usr/local/bin/aspell")


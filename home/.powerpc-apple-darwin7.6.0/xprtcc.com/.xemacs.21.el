;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.powerpc-apple-darwin7.6.0/xprtcc.com/.xemacs.21.el#1 $
;;

;;
;; Set up bbdb
;;

;; (require 'bbdb)
;; (bbdb-initialize 'gnus 'message 'sc 'w3 'vm)

;;
;; Set up auctex
;;

(require 'tex-site)

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

(if window-system
    (progn
      (require 'font-latex)
      (add-hook 'latex-mode-hook 'turn-on-font-lock 'append) ; with AUCTeX LaTeX mode
      (add-hook 'LaTeX-mode-hook 'turn-on-font-lock 'append) ; with Emacs latex mode
))

;;
;; Add reftex
;;

(autoload 'turn-on-reftex "reftex")
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode

;;
;; Add bib-cite
;;

(autoload 'turn-on-bib-cite "bib-cite")
(add-hook 'LaTeX-mode-hook 'turn-on-bib-cite)
(add-hook 'latex-mode-hook 'turn-on-bib-cite)

;;
;; Use the mouse wheel
;;

(autoload 'mwheel-install "mwheel" "Enable mouse wheel support.")
(mwheel-install)

;;
;; Don't use the kerberos ftp 
;;

(setq efs-ftp-program-name "/usr/bin/ftp")

;;
;; This also could be used
;;

;; (eval-after-load "efs"
;;  '(setq efs-ftp-program-args (cons "-u" efs-ftp-program-args)))

  
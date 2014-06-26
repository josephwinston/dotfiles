;; -*- Emacs-Lisp -*-

;;
;; $Id: .xemacs.20.el,v 1.1 2000/09/05 00:24:12 CVS_jody Exp $
;;

(setq ps-lpr-command "lp")

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


;; -*- Emacs-Lisp -*-

;;
;; Old splitting mode
;;

(setq split-width-threshold nil)

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

;;
;; p4
;;

;; (load-library "p4")
;; (setq p4-executable "/usr/local/bin/p4")

(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'cmake-mode "~/Tools/share/emacs/site-lisp/cmake-mode.el" t)

;;
;; scala
;;

(add-to-list 'load-path "~/Tools/share/emacs/site-lisp/scala")
(require 'scala-mode-auto)

(defun scala-turnoff-indent-tabs-mode ()
  (setq indent-tabs-mode nil))

;;
;; scala mode hooks
;;

(add-hook 'scala-mode-hook 'scala-turnoff-indent-tabs-mode)

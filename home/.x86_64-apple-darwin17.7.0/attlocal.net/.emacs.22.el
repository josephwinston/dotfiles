;; -*- Emacs-Lisp -*-

;;
;; $Id: .emacs.21.el,v 1.1 2004/08/09 23:13:08 CVS_jody Exp $
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
;; spelling
;;

;; (setq ispell-program-name "/usr/local/bin/ispell")

;;
;; p4
;;

(load-library "p4")
(setq p4-executable "/usr/local/bin/p4")
(setenv "P4CLIENT" "jwinston-powerbook-powerpc-apple-darwin7.9.0")
(setenv "P4PORT" "localhost:2201")
(setenv "P4USER" "jwinston")

;;
;; igrep
;;

(autoload 'igrep "igrep"
   "*Run `grep` PROGRAM to match REGEX in FILES..." t)
(autoload 'igrep-find "igrep"
   "*Run `grep` via `find`..." t)
(autoload 'igrep-visited-files "igrep"
   "*Run `grep` ... on all visited files." t)
(autoload 'dired-do-igrep "igrep"
   "*Run `grep` on the marked (or next prefix ARG) files." t)
(autoload 'dired-do-igrep-find "igrep"
   "*Run `grep` via `find` on the marked (or next prefix ARG) directories." t)
(autoload 'Buffer-menu-igrep "igrep"
  "*Run `grep` on the files visited in buffers marked with '>'." t)
(autoload 'igrep-insinuate "igrep"
  "Define `grep' aliases for the corresponding `igrep' commands." t)

(autoload 'grep "igrep"
   "*Run `grep` PROGRAM to match REGEX in FILES..." t)
(autoload 'egrep "igrep"
   "*Run `egrep`..." t)
(autoload 'fgrep "igrep"
   "*Run `fgrep`..." t)
(autoload 'agrep "igrep"
   "*Run `agrep`..." t)
(autoload 'grep-find "igrep"
   "*Run `grep` via `find`..." t)
(autoload 'egrep-find "igrep"
   "*Run `egrep` via `find`..." t)
(autoload 'fgrep-find "igrep"
   "*Run `fgrep` via `find`..." t)
(autoload 'agrep-find "igrep"
   "*Run `agrep` via `find`..." t)

;; -*- Emacs-Lisp -*-

;;
;; $Id: .emacs,v 1.1 2000/09/05 00:13:27 CVS_jody Exp $
;;

;; (setq debug-on-error t)

;;
;; Emacs
;;

;;
;; Don't warn about symlinks to version controlled files
;;

(setq vc-follow-symlinks nil)

;;
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;
;; If this isn't here some stupid package adds this

;; (package-initialize)

(defvar running-emacs18 nil)
(defvar running-emacs19 nil)
(defvar running-emacs20 nil)
(defvar running-emacs21 nil)
(defvar running-emacs22 nil)
(defvar running-emacs23 nil)
(defvar running-emacs24 nil)
(defvar running-emacs25 nil)
(defvar running-emacs26 nil)

(defvar running-pearl nil)
(defvar running-epoch nil)
(defvar running-lucid nil)

(defvar running-xemacs20 nil)
(defvar running-xemacs21 nil)

;; (global-set-key [delete] 'delete-char)
;; (global-set-key [kp-delete] 'delete-char)

(if (string-match "^18\\." emacs-version)
    (setq running-emacs18 t))

(if (string-match "^19\\." emacs-version)
    (setq running-emacs19 t))

(if (string-match "^20\\." emacs-version)
    (setq running-emacs20 t))

(if (string-match "XEmacs" emacs-version)
    (setq running-emacs20 nil))

(if (string-match "^21\\." emacs-version)
    (setq running-emacs21 t))

(if (string-match "^22\\." emacs-version)
    (setq running-emacs22 t))

(if (string-match "^23\\." emacs-version)
    (setq running-emacs23 t))

(if (string-match "^24\\." emacs-version)
    (setq running-emacs24 t))

(if (string-match "^25\\." emacs-version)
    (setq running-emacs25 t))

(if (string-match "^26\\." emacs-version)
    (setq running-emacs26 t))

(if (string-match "XEmacs" emacs-version)
    (setq running-emacs21 nil))

;;
;; For Epoch
;;

(setq running-epoch (boundp 'epoch::version))

;;
;; lucid
;;

(if (or (string-match "Lucid" emacs-version)
	(string-match "Win" emacs-version))
    (progn
      (setq running-lucid t)
      (if (string-match "^20\\." emacs-version)
	  (progn
	    (setq running-lucid nil)
	    (setq running-xemacs20 t)))
      (if (string-match "^21\\." emacs-version)
	  (progn
	    (setq running-lucid nil)
	    (setq running-xemacs21 t)))
      )
  )

;;
;; pearl
;;

(if (string-match "Win" emacs-version)
    (setq running-pearl t))

;;
;; Get the terminal type and store it
;;

(defvar term-type (getenv "TERM")
  "*Terminal type")

;;
;; Get the cpu type and store it
;;

;; (defvar mach-type (getenv "MACH")
;;   "*Machine type")

(setq mach-type "i686-pc-cygwin")

(if running-pearl
    (setq mach-type "WINDOWS"))

;;
;; msdos demacs
;;

(if (and (not running-pearl) running-emacs18 (string-match "MSDOS" mach-type))
    (defvar running-demacs t)
  (defvar running-demacs nil))

;;
;; Get the hostname and store it
;;

(defvar host-name (getenv "HOSTNAME")
  "*Host name")

(load "~/.common")

(if running-demacs
    (load "~/.demacs"))

(if running-lucid
    (load "~/.lucid"))

(if running-emacs18
    (load "~/.emacs.18"))

(if running-emacs19
    (load "~/.emacs.19"))

(if running-emacs20
    (load "~/.emacs.20"))

(if running-emacs21
    (load "~/.emacs.21"))

(if running-emacs22
    (load "~/.emacs.22"))

(if running-emacs23
    (load "~/.emacs.23"))

(if running-emacs24
    (load "~/.emacs.24"))

(if running-emacs25
    (load "~/.emacs.25"))

(if running-emacs26
    (load "~/.emacs.26"))

(if running-xemacs20
    (load "~/.xemacs.20"))

(if running-xemacs21
    (load "~/.xemacs.21"))

(if (not running-pearl)
    (load "~/.mode"))

;; 
;; Invoke the code
;;

(jbw-startup)
(jbw-environment)

;;
;; Where the my emacs files are
;;

(load "~/.$FULLNAME/$DOMAIN/.last" t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-time-mode t)
 '(package-selected-packages
   (quote
    (cider ## company-irony company markdown-mode python-mode cmake-mode csharp-mode)))
 '(safe-local-variable-values
   (quote
    ((TeX-master quote
		 (quote main))
     (TeX-master . t)
     (TeX-master \`
		 (\` main))
     (TeX-master . "./main")
     (TeX-master . bible\.tex)
     (py-indent-offset . 2)
     (TeX-master . "main"))))
 '(save-place t nil (saveplace))
 '(tool-bar-mode nil))

(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 132 :width normal)))))
(put 'narrow-to-page 'disabled nil)

(set-background-color "white")


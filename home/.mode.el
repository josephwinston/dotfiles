;; -*- Emacs-Lisp -*-

;;
;; $Id: .mode.el,v 1.1 2006/05/24 19:22:07 jody Exp jody $
;;

;; Set auto-fill for text mode
(setq text-mode-hook '(lambda () (auto-fill-mode 1)))

;;
;; filladapt
;;

;; (require 'filladapt)
;; (setq-default filladapt-mode t)

;; If you can do a "C-h v c-mode-map" you probably need to add these
;; lines at the top of your .emacs file:

(if running-emacs18
    (progn
      (fmakunbound 'c-mode)
      (makunbound 'c-mode-map)
      (makunbound 'c++-mode)
      (makunbound 'c++-mode-map)
      (makunbound 'c-style-alist)))

;; After those lines you will want to add the following autoloads to
;; your .emacs file so that cc-mode gets loaded at the right time:

(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode    "cc-mode" "C Editing Mode" t)
(autoload 'objc-mode "cc-mode" "Objective-C Editing Mode" t)
(autoload 'java-mode "cc-mode" "Java Editing Mode" t)

;;
;; Set the mode based on the file suffix
;;

(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
		("\\.cc$" . c++-mode)
		("\\.c\\+\\+$" . c++-mode)
		("\\.cpp$" . c++-mode)
		("\\.cxx$" . c++-mode)
		("\\.hh$" . c++-mode)
		("\\.c$"  . c-mode)
		("\\.h$"  . c-mode)
		("\\.m$"    . objc-mode)
		("\\.tmpl$"  . c-mode)
		("\\.def$"  . c-mode)
		("\\.cf$"  . c-mode)
		) auto-mode-alist))


(defconst my-c-style
  '("PERSONAL"
    (c-basic-offset                . 3)
    (c-offsets-alist               . (
				      (string . -1000)
				      (c . c-lineup-C-comments)
				      (defun-open . 0)
				      (defun-close . 0)
				      (defun-block-intro . +)
				      (class-open . 0)
				      (class-close . 0)
				      (inline-open . 0)
				      (inline-close . 0)
;;				      (ansi-funcdecl-cont . -)
				      (knr-argdecl-intro . 0)
				      (knr-argdecl . 0)
				      (topmost-intro . 0)
				      (topmost-intro-cont . 0)
				      (member-init-intro . -)
				      (member-init-cont . 0)
				      (inher-intro . +)
				      (inher-cont . c-lineup-multi-inher)
				      (block-open . -)
				      (block-close . 0)
				      (brace-list-open . 0)
				      (brace-list-close . 0)
				      (brace-list-intro . +)
				      (brace-list-entry . 0)
				      (statement . 0)
				      (statement-cont . +)
				      (statement-block-intro . +)
				      (statement-case-intro . +)
				      (substatement . +)
				      (substatement-open . 0)
				      (case-label . +)
				      (access-label . -)
				      (label . -)
				      (do-while-closure . 0)
				      (else-clause . 0)
				      (comment-intro . c-lineup-comment)
				      (arglist-intro . +)
				      (arglist-cont . +)
				      (arglist-cont-nonempty . c-lineup-arglist)
				      (arglist-close . c-lineup-arglist)
				      (stream-op . c-lineup-streamop)
				      (inclass . +)
				      (cpp-macro . -1000)
				      (friend . 0)
				      ))
    (c-block-comments-indent-p     . nil)
    (c-cleanup-list                . (scope-operator
				      empty-defun-braces
				      defun-close-semi)) 
    (c-comment-only-line-offset    . 0)
    (c-backslash-column            . 48)
;; This causes problems in Xemacs 21, delete backspaces
;;    (c-delete-function             . backward-delete-char-untabify)
    (c-electric-pound-behavior     . nil)
    (c-hanging-braces-alist        . (
				      (brace-list-open)
				      ))
    (c-hanging-colons-alist        . (
				      (member-init-intro before)
				      (inher-intro)
				      (case-label after)
				      (label after)
				      (access-key after)
				      ))
    (c-tab-always-indent           . t)
    (c-echo-semantic-information-p . nil)
    )
  "My C Programming Style")


;;
;; Customizations for both c-mode, c++-mode, objc-mode, and java-mode
;;

(defun my-c-mode-common-hook ()
  ;; set up for my perferred indentation style, but only do it once
  (let ((my-style "PERSONAL"))
    (or (assoc my-style c-style-alist)
	(setq c-style-alist (cons my-c-style c-style-alist)))
    (c-set-style my-style))
  ;; other customizations
  (setq tab-width 8
	;; this will make sure spaces are used instead of tabs
	indent-tabs-mode nil
	)
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state 1)
  ;; c-mode-map because c++-mode-map, objc-mode-map, and java-mode-map
  ;; inherit from it.
  (define-key c-mode-map "\C-m" 'newline-and-indent)
  )

(if running-emacs18
    (setq c-mode-common-hook 'my-c-mode-common-hook)
  (add-hook 'c-mode-common-hook 'my-c-mode-common-hook))

;;
;; For crontab files
;;

(autoload 'crontab-edit "crontab"
  "Function to allow the easy editing of crontab files." t)


;;
;; for otl
;;

(setq auto-mode-alist
      (append '(("\\.otl$" . outline-mode)) auto-mode-alist))

;;
;; for FORTRAN
;;

(setq auto-mode-alist
      (append '(("\\.F$" . fortran-mode)
		("\\.f77$" . fortran-mode)
		) auto-mode-alist))

;;
;; for gwm
;;

(setq auto-mode-alist
      (append '(("\\.gwm$" . lisp-mode)) auto-mode-alist))

;;
;; for awk
;;

(setq auto-mode-alist
      (append '(("\\.awk$" . awk-mode)) auto-mode-alist))

;;
;; for make
;; 

(setq auto-mode-alist
      (append '(("Makefile" . makefile-mode)
		("makefile" . makefile-mode)
		("GMakefile" . makefile-mode)
		("Imakefile" . makefile-mode)
		) auto-mode-alist))

;; For Xdefaults
(defun Xdefaults-mode ()
  "Set up for editing Xdefaults (a minor variation on Fundamental mode)"
  (interactive)
  (fundamental-mode)
  (setq mode-name "Xdefaults"))

(setq auto-mode-alist
     (append '(("\\.Xdefaults$" . Xdefaults-mode)) auto-mode-alist))

;; For Purify
(defun PureLog-mode ()
  "Set up for editing pure logs (a minor variation on Fundamental mode)"
  (interactive)
  (fundamental-mode)
  (setq mode-name "PureLog"))

(setq auto-mode-alist
     (append '(("pure.log" . PureLog-mode)) auto-mode-alist))

(defun Purify-mode ()
  "Set up for editing .purify (a minor variation on Fundamental mode)"
  (interactive)
  (fundamental-mode)
  (setq mode-name "Purify"))

(setq auto-mode-alist
     (append '(("\\.purify$" . Purify-mode)) auto-mode-alist))

;; For PostScript
(autoload 'postscript-mode "postscript.el" "" t)

(setq auto-mode-alist
     (append '(("\\.ps$" . postscript-mode)) auto-mode-alist))

;;
;; for bibtex
;;

(if (not running-demacs)
    (progn
      (load "bibtex")

      (if (not running-emacs19)
	  (progn
	    (setq auto-mode-alist
		  (append '(("\\.bib$" . bibtex-mode)) auto-mode-alist))
	    ))))

;;
;; For csh
;;

(autoload 'csh-mode "csh-mode" "Major mode for editing csh Scripts." t)

(setq auto-mode-alist
      (append auto-mode-alist
	      (list
;;	       '("\\.log$" . csh-mode)
	       '("\\.cshrc$" . csh-mode)
	       '("\\.alias$" . csh-mode)
	       '("\\.setenv$" . csh-mode))))


;;
;; For bash, sh, and ksh
;;

(autoload 'ksh-mode "ksh-mode" "Major mode for editing sh Scripts." t)

(setq auto-mode-alist
      (append auto-mode-alist
	      (list
	       '("\\.sh$" . ksh-mode)
	       '("\\.ksh$" . ksh-mode)
               '("\\.bashrc" . ksh-mode)
               '("\\..*profile" . ksh-mode))))

(if (and
     (not running-emacs23)
     (not running-emacs24)
     (not running-emacs25)
     (not running-emacs26)
     (not running-emacs27)
     )
    (progn
      (setq ksh-mode-hook
	    (function (lambda ()
			(font-lock-mode 1)             ;; font-lock the buffer
			(setq ksh-indent 3)
			(setq ksh-group-offset -3))
		      (setq ksh-brace-offset -3)   
		      (setq ksh-tab-always-indent t)
		      (setq ksh-match-and-tell t)
		      (setq ksh-align-to-keyword t)	;; Turn on keyword alignment
		      ))
      ))
;;
;; Shell
;;

(if (not running-demacs)
    (require 'shell))

;;
;; Get dbx
;;

(if (and (not running-demacs) 
	 (not running-emacs19) 
	 (not running-emacs20) 
	 (not running-emacs21) 
	 (not running-emacs22) 
	 (not running-emacs23)
	 (not running-emacs24)
	 (not running-emacs25)
	 (not running-emacs26)
	 (not running-emacs27)
	 )
    (load "dbx"))

;;
;; Get hideif
;;

(if (and (not running-demacs) (not running-emacs19))
    (progn
      (load "hideif")
      (setq hide-ifdef-read-only t)
      ))

(if (and
     (not running-demacs)
     (not running-emacs23)
     (not running-emacs24)
     (not running-emacs25)
     (not running-emacs26)
     (not running-emacs27)
     )
    (setq debugger 'edebug-debug))

;;
;; python
;;

(if (and (not running-emacs23)
	 (not running-emacs24)
	 )
    (progn
      (autoload 'python-mode "python-mode" "Python editing mode." t)
      (setq auto-mode-alist
	    (cons '("\\.py$" . python-mode) auto-mode-alist))
      ))

(if (and (not running-emacs25)
	 (not running-emacs26)
	 (not running-emacs27)
	 )
    (progn
      (require 'python)      
      ))

;;
;; for otcl and tk
;;

(setq auto-mode-alist
      (append '(("\\.otcl$" . tcl-mode)) auto-mode-alist))

(setq auto-mode-alist
      (append '(("\\.tk$" . tcl-mode)) auto-mode-alist))

;;
;; For isl
;;

(autoload 'isl-mode "isl-mode.el" "isl editing mode" t) 
(setq auto-mode-alist (cons '("\\.isl$" . isl-mode) auto-mode-alist))

;;
;; For idl
;;

(autoload 'idl-mode "idl-mode.el" "idl editing mode" t) 
(setq auto-mode-alist (cons '("\\.idl$" . idl-mode) auto-mode-alist))

;;
;; get gnus
;;

(load (concat home-directory "/.$FULLNAME/$DOMAIN/.gnus") t)


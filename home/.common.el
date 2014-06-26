;; -*- Emacs-Lisp -*-

;;
;; $Id: .common.el,v 1.2 2001/09/18 22:27:43 CVS_jody Exp $
;;

;;
;; load up the home directory for Apple's Finder
;;

(if nil home-directory
  (setq home-directory "~"))

;;
;; Where the my emacs files are
;;

(load "~/.$FULLNAME/$DOMAIN/.site" t)

;;
;; Useful functions
;;

;; 
;; Kill All unmodified buffers
;;

;;
;; Don't put this on a key
;; (define-key ctl-x-map "\C-k" 'kill-buffers)

(defun kill-buffers ()
  "Kill all buffers, asking permission on unmodified ones."
  (interactive)
  (let ((list (buffer-list)))
    (while list
      (let* ((buffer (car list))
             (name (buffer-name buffer)))
        (and (not (string-equal name ""))
             (kill-buffer buffer)))
      (setq list (cdr list))))
  (cd "~"))

;;; Regrep files

;;;
;;; written by jak@cs.brown.edu.  opens up all the files in a
;;; directory that match a regexp, either csh style or emacs style.
;;; Default regexp is *.[chyl].
;;;

(if (not running-pearl)
    (progn

      (defun csh-re-to-regexp (reg)
	"Convert a C-shell regular expression to a true r.e."
	(concat "^" (mapconcat 'convert-csh-re-to-regexp reg "") "$"))

      (defun convert-csh-re-to-regexp (ch)
	"Convert a C-shell wildcard to its regular expression counterpart"
	(cond ((equal ch ?.) "\\.")
	      ((equal ch ?*) ".*")
	      ((equal ch ??) ".")
	      (t (char-to-string ch))))

      (defun find-regexp-files (prefix dir reg)
	"Prompt for a directory and a regular expression.  Open 
buffers for all the files matching that regular expression in the
directory.  The default RE is *.[chyl]."
	(interactive "p\nDDirectory: \nsRegexp: ")
	(if (equal reg "")
	    (setq reg ".*\\.\\(c\\|h\\|y\\|l\\)$")
	  (if (equal prefix 1)
	      (setq reg (csh-re-to-regexp reg))))
	(setq files (directory-files dir t reg))
	(if (not files)
	    (message "no matching files"))
	(while files
	  (find-file (car files))
	  (setq files (cdr files))))
      ))

;;
;; Tools
;;

(defun kill-cpp-line-numbers ()
  "Remove the line numbers added by cpp"
  (interactive)
  (replace-regexp "^#[ ]*[0-9]+." "")
  (replace-regexp "^[ 	]*[ 	]*$" "")
  (replace-regexp "[
]$" ""))

;;
;; Tell RMAIL where to place the mail
;;

(setq rmail-last-rmail-file "~/mail/general")

;;
;; Bind a few keys to be more like PC-emacs (i.e. 3.9n)
;;

(define-key esc-map "g" 'goto-line)
(define-key esc-map "r" 'replace-string)

;;
;; save all my outgoing mail
;;

(setq mail-archive-file-name "~/mail/outgoing")

(defconst month-number-alist 
  '(("Jan" . "01") ("Feb" . "02") ("Mar" . "03")
    ("Apr" . "04") ("May" . "05") ("Jun" . "06")
    ("Jul" . "07") ("Aug" . "08") ("Sep" . "09")
    ("Oct" . "10") ("Nov" . "11") ("Dec" . "12"))
  "assoc list of months/numeric string numbers.")
month-number-alist

(defun insert-date-stamp ()
  "Put date-stamp at point."
  (interactive)
  (let ((date (current-time-string)))
    (insert "[" (getenv "USER") " " 
	    (substring date -2 nil)	; yyyy
	    "/"
	    (cdr (assoc (substring date 4 7)
			month-number-alist)) ; MM
	    "/"
	    (let ((d (substring date 8 9)))
	      (if (equal d " ") "0" d))
	    (substring date 9 10)	; d
	    " "
	    (substring date 11 13)	; hh
	    ":"
	    (substring date 14 16)	; mm
	    "]")))
(global-set-key "\C-cd" 'insert-date-stamp)


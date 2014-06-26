;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.emacs.18.el#1 $
;;

(if (not running-demacs)
    (setq debugger 'edebug-debug))

;;
;; The file is done this way so that the emacs 18 byte compilers will work
;;

(defun jbw-startup()
  "Local startup code"
  (interactive)

  ;; Time between gc
  (setq gc-cons-threshold 4000000)

  ;; Turn off startup message
  (setq inhibit-startup-message t)
  
  ;; Turn off local vars
  (setq inhibit-local-variables t)
  
  ;; setup shell file name
  (setq shell-file-name "sh")

  )

(defun jbw-environment()
  "Local environment code"
  (interactive)
  
  ;; Save my environment
  ;;(setq auto-save-and-recover-context t)
  (setq save-buffer-context t)
  
  ;; Display the time
  (display-time)
  (setq display-time-day-and-date t)

  ;; Save Old Versions of my files
  (setq version-control t)
  
  ;; Keep Only the last 3
  (setq make-backup-files t)
  (setq version-control t)
  (setq kept-old-versions 0)
  (setq kept-new-versions 3)
  
  ;; Don't ask when emacs deletes old versions
  (setq trim-versions-without-asking t)
  (setq delete-old-versions t)
  )


;;
;; diary and calendar
;;

;; Where are my diary entries?

(setq diary-file "~/.diary")

(if (file-exists-p diary-file)
    (progn
      (load "calendar")
      (load "holidays")
      (autoload 'diary "diary"
		"Display a window of diary entries." t)
      
      ;; My sexps
      (defun calendar-day-equal (date1 date2)
	"Returns t if the DATE1 and DATE2 are the same. (Does not check month)"
	(and
	 (= (extract-calendar-day date1) (extract-calendar-day date2))
	 (= (extract-calendar-year date1) (extract-calendar-year date2))))
      
      (defun diary-any-month-float (dayname n)
	"Floating diary entry--entry applies if date is the nth dayname of any month."
	(if (calendar-day-equal
	     date (calendar-nth-named-day
		   n dayname (extract-calendar-month date)
		   (extract-calendar-year date)))
	    entry))
      
      ;; What to mark
      
      (setq mark-holidays-in-calendar t)
      (setq mark-diary-entries-in-calendar t)
      
      ;; do we have any messages today
      
      (setq view-diary-entries-initially t)
      (setq view-calendar-holidays-initially t)
      
      ;; What days to show in diary
      ;; Show the next 7 days every day
      
      (setq number-of-diary-entries [7 7 7 7 7 7 7])
      
      ;; What holidays
      
      (setq all-hebrew-calendar-holidays nil)
      (setq all-islamic-calendar-holidays nil)
      (setq all-christian-calendar-holidays t)
      
      (setq diary-list-include-blanks t)

      ;; Hooks
      
      (setq diary-display-hook 'fancy-diary-display)
      
      ;;(setq nongregorian-diary-marking-hook 'mark-hebrew-diary-entries)
      ;;(setq nongregorian-diary-listing-hook 'list-hebrew-diary-entries)
      
      (setq mark-diary-entries-hook 'mark-included-diary-files)
      (setq list-diary-entries-hook
	    '(include-other-diary-files
	      (lambda nil
		(setq diary-entries-list
		      (sort diary-entries-list 'diary-entry-compare)))))
      
      
      (diary)))


;;
;; for RCS
;;

(setq rcs-mode-hook '(lambda ()
		       (setq fill-column 76)
		       (setq fill-prefix "\t")))

(autoload 'rcs "rcs" "" t)

(setq find-file-not-found-hooks (cons 'my-RCS-file nil))

;;
;; get ispell
;;

(autoload 'ispell-word "ispell" "Check spelling of word at or before point" t)
(autoload 'ispell-complete-word "ispell" "Complete word at or before point" t)
(autoload 'ispell-region "ispell" "Check spelling of every word in the region" t)
(autoload 'ispell-buffer "ispell" "Check spelling of every word in the buffer" t)

;; Coerce emacs into automagically rebuilding mail aliasii when .mailrc edited 
;;    Inspired by Mike Meissner (meissner@osf.org)

(defun rebuild-mail-aliases ()
  "Hook to rebuild the mail aliases, whenever ~/.mailrc is stored."
  (if (string-equal buffer-file-name (expand-file-name "~/.mailrc"))
      (progn
	(setq mail-aliases t)		;Force sendmail to [re]read .mailrc
	nil)))				;Procede normally to save the file

(if (not (memq 'rebuild-mail-aliases write-file-hooks))
    (setq write-file-hooks (cons 'rebuild-mail-aliases
				 write-file-hooks)))

;; The following kludge is to stop Emacs
;; inserting newlines when you reach the
;; bottom of the buffer using C-n

(if (not (fboundp 'real-next-line))
    (fset 'real-next-line (symbol-function 'next-line)))

(defun next-line (&optional arg)
  (interactive "P")
  (if (save-excursion (end-of-line) (and (eobp) (bolp)))
      (if (interactive-p) (error "End of Buffer"))
    (real-next-line (or arg 1))))

;;
;; for c++
;;

(setq auto-mode-alist
      (append '(("\\.cc$" . c++-mode)) auto-mode-alist))

(setq auto-mode-alist
      (append '(("\\.cpp$" . c++-mode)) auto-mode-alist))

(setq auto-mode-alist
      (append '(("\\.C$" . c++-mode)) auto-mode-alist))

;;
;; Makefile
;;

(defun makefile-mode ()
  "Set up for editing Makefile (a minor variation on Fundamental mode"
  (interactive)
  (fundamental-mode)
  (setq mode-name "Makefile"))

;;
;; For tar
;;

(setq auto-mode-alist (cons '("\\.tar$" . tar-mode) auto-mode-alist))
(autoload 'tar-mode "tar-mode")


;; Modified by cwitty@csli.Stanford.EDU (Carl Witty) on 12/4/88
;; to show "Local Variables" section of file on screen before
;; asking whether to use them (when inhibit-local-variables set).

(defun hack-local-variables (&optional force)
  "Parse, and bind or evaluate as appropriate, any local variables
for current buffer."
  ;; Look for "Local variables:" line in last page.
  (save-excursion
    (goto-char (point-max))
    (search-backward "\n\^L" (max (- (point-max) 3000) (point-min)) 'move)
    (if (let ((case-fold-search t))
	  (and (search-forward "Local Variables:" nil t)
	       (or (not inhibit-local-variables)
		   force
		   ;; modified by cwitty to show local variables before asking
		   ;; 12/4/88
		   (save-window-excursion
		     (switch-to-buffer (current-buffer) t)
		     (recenter 0)
		     (y-or-n-p (format"Set local variables as specified at end of %s? "
				      (file-name-nondirectory buffer-file-name)))))))
	(let ((continue t)
	      prefix prefixlen suffix beg)
	  ;; The prefix is what comes before "local variables:" in its line.
	  ;; The suffix is what comes after "local variables:" in its line.
	  (skip-chars-forward " \t")
	  (or (eolp)
	      (setq suffix (buffer-substring (point)
					     (progn (end-of-line) (point)))))
	  (goto-char (match-beginning 0))
	  (or (bolp)
	      (setq prefix
		    (buffer-substring (point)
				      (progn (beginning-of-line) (point)))))
	  (if prefix (setq prefixlen (length prefix)
			   prefix (regexp-quote prefix)))
	  (if suffix (setq suffix (regexp-quote suffix)))
	  (while continue
	    ;; Look at next local variable spec.
	    (if selective-display (re-search-forward "[\n\C-m]")
	      (forward-line 1))
	    ;; Skip the prefix, if any.
	    (if prefix
		(if (looking-at prefix)
		    (forward-char prefixlen)
		  (error "Local variables entry is missing the prefix")))
	    ;; Find the variable name; strip whitespace.
	    (skip-chars-forward " \t")
	    (setq beg (point))
	    (skip-chars-forward "^:\n")
	    (if (eolp) (error "Missing colon in local variables entry"))
	    (skip-chars-backward " \t")
	    (let* ((str (buffer-substring beg (point)))
		   (var (read str))
		   val)
	      ;; Setting variable named "end" means end of list.
	      (if (string-equal (downcase str) "end")
		  (setq continue nil)
		;; Otherwise read the variable value.
		(skip-chars-forward "^:")
		(forward-char 1)
		(setq val (read (current-buffer)))
		(skip-chars-backward "\n")
		(skip-chars-forward " \t")
		(or (if suffix (looking-at suffix) (eolp))
		    (error "Local variables entry is terminated incorrectly"))
		;; Set the variable.  "Variables" mode and eval are funny.
		(cond ((eq var 'mode)
		       (funcall (intern (concat (downcase (symbol-name val))
						"-mode"))))
		      ((eq var 'eval)
		       (if (string= (user-login-name) "root")
			   (message "Ignoring `eval:' in file's local variables")
			 (eval val)))
		      (t (make-local-variable var)
			 (set var val))))))))))






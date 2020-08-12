;;
;; $Id: .emacs.20.el,v 1.2 2001/09/18 22:16:56 CVS_jody Exp $
;;

;; -*- Emacs-Lisp -*-

;;
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;

(package-initialize)


(defun jbw-startup()
  "Local startup code"
  (interactive)

  ;; Turn off startup message
  (setq inhibit-startup-message t)
  )

(defun jbw-environment()
  "Local environment code"
  (interactive)
  
  ;; Save my environment
  ;;(setq auto-save-and-recover-context t)
  (setq save-buffer-context t)
  
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
;; Local files
;;

(setq load-path (cons (concat home-directory "/Tools/share/emacs/site-lisp") load-path))

;;
;; floats
;;

(load "float-sup")

;;
;; Perl
;;

(autoload 'perl-mode "perl-mode")
(setq auto-mode-alist (append (list (cons "\\.pl$" 'perl-mode))
			      auto-mode-alist))
;;
;; igrep
;;

(autoload (function igrep) "igrep"
  "*Run `grep' to match EXPRESSION in FILES..." t)
(autoload (function egrep) "igrep"
  "*Run `egrep'..." t)
(autoload (function fgrep) "igrep"
  "*Run `fgrep'..." t)
(autoload (function igrep-recursively) "igrep"
  "*Run `grep' recursively..." t)
(autoload (function egrep-recursively) "igrep"
  "*Run `egrep' recursively..." t)
(autoload (function fgrep-recursively) "igrep"
  "*Run `fgrep' recursively..." t)

(cond (window-system

       (if t
           (progn

	     (defun my-font-lock-look()
	       "How I like the code to look like."
	       (setq lisp-font-lock-keywords lisp-font-lock-keywords-2)
	       (setq c-font-lock-keywords c-font-lock-keywords-2)
	       (setq c++-font-lock-keywords c-font-lock-keywords-2)

	       ;; Comments will be displayed in `font-lock-comment-face'.
	       ;; Strings will be displayed in `font-lock-string-face'.
	       ;; Doc strings will be displayed in `font-lock-doc-string-face'.
	       ;; Function and variable names (in their defining forms) will be
	       ;;  displayed in `font-lock-function-name-face'.
	       ;; Reserved words will be displayed in `font-lock-keyword-face'.

	       (modify-face (quote font-lock-comment-face) "Purple" nil nil nil nil)
	       (modify-face (quote font-lock-doc-string-face) "SteelBlue" nil nil nil nil)
	       (modify-face (quote font-lock-string-face) "DeepPink" nil nil nil nil)
	       (modify-face (quote font-lock-keyword-face) "RoyalBlue" nil nil nil nil)
	       (modify-face (quote font-lock-function-name-face) "Blue" t nil nil nil)
	       (modify-face (quote font-lock-type-face) "DeepSkyBlue" nil nil nil nil)
	     )

             ;;
             ;; Nice to highlight and type but it's too slow
	     ;; in 19.19 since the caching mechanism is broken in 19.19
             ;;
	     
;              (autoload 'face-lock-mode "face-lock" "Toggle Face Lock mode." t)
;              (autoload 'face-lock-facify-buffer "face-lock"
;                "Facify the current buffer the way `face-lock-mode' would." t)

;              (autoload 'turn-on-face-lock "face-lock"
;                "Unconditionally turn on Face Lock mode.")

              (add-hook 'c++-mode-hook 'turn-on-font-lock)
              (add-hook 'c-mode-hook 'turn-on-font-lock)
              (add-hook 'emacs-lisp-mode-hook 'turn-on-font-lock)
              (add-hook 'makefile-mode-hook 'turn-on-font-lock)
              (add-hook 'perl-mode-hook 'turn-on-font-lock)
              (add-hook 'python-mode-hook 'turn-on-font-lock)
              (add-hook 'tex-mode-hook 'turn-on-font-lock)
              (add-hook 'latex-mode-hook 'turn-on-font-lock)

;              (autoload 'turn-on-fast-lock "fast-lock"
;                "Unconditionally turn on Fast Lock mode.")

;              (add-hook 'font-lock-mode-hook 'turn-on-fast-lock)
;              (add-hook 'font-lock-mode-hook 'my-font-lock-look)

             )
	 (
	  (progn
	    (setq hilit-mode-enable-list  '(not text-mode)
		  hilit-inhibit-hooks     nil
		  hilit-inhibit-rebinding nil)

	    (require 'hilit19)

	    ;;	    (setq hilit-mode-enable-list 
	    ;;		   '(not emacs-lisp-mode c++-mode c-mode dired-mode makefile-mode))


	    (hilit-translate type     'DeepSkyBlue ; enable C++ built in types
			     string	 'DeepPink) ; make strings pink 
	    )))

       (global-set-key [C-right] 'forward-word)
       (global-set-key [C-left] 'backward-word)
       (global-set-key [C-up] 'previous-line)
       (global-set-key [C-down] 'next-line)
       (global-set-key [C-home] 'beginning-of-buffer)
       (global-set-key [C-end] 'end-of-buffer)
       (if (string-match "sparc" mach-type)
	   (progn
	     (global-set-key [f27] 'beginning-of-buffer)
	     (global-set-key [f33] 'end-of-buffer)
	     (global-set-key [f29] 'scroll-down)
	     (global-set-key [f35] 'scroll-up)
	     ))
       ))

; (cond (window-system
;        (require 'stig-paren)
;        (setq blink-matching-paren nil)
;        (global-set-key [?\C-\(] 'stig-paren-toggle-dingaling-mode)
;        (global-set-key [?\C-\)] 'stig-paren-toggle-sexp-mode))
;       (t
;        (setq blink-matching-paren t)))

(load (concat home-directory "/.calendar"))

;;
;; Supercite
;;

(load "supercite")

;; (add-hook 'mail-citation-hook 'sc-cite-original)
;; (setq news-reply-header-hook nil)

;;
;; Display
;;

(cond (window-system
       (setq mark-even-if-inactive t)
       (setq transient-mode nil)))

(require 'paren)

;;
;; RMAIL 
;;

(setq rmail-default-file "~/mail/general")

;;
;; Crypt
;;

;; (require 'crypt++)

;;
;; Flow control
;;

;; (enable-flow-control-on "vt220" "vt100" )

;;
;; Rlogin
;;

(setq rlogin-mode-hook
      '(lambda ()
	 (define-key rlogin-mode-map "\t" 'comint-dynamic-complete)
	 (define-key rlogin-mode-map "\M-?"  'comint-dynamic-list-completions)
	 (define-key rlogin-mode-map "\e\C-f" 'shell-forward-command)
	 (define-key rlogin-mode-map "\e\C-b" 'shell-backward-command)))

;;
;; Telnet
;;

(setq telnet-mode-hook
      '(lambda ()
	 (define-key telnet-mode-map "\t" 'comint-dynamic-complete)
	 (define-key telnet-mode-map "\M-?"  'comint-dynamic-list-completions)
	 (define-key telnet-mode-map "\e\C-f" 'shell-forward-command)
	 (define-key telnet-mode-map "\e\C-b" 'shell-backward-command)))

;;
;; Ispell
;;

(autoload 'ispell-word "ispell"
  "Check the spelling of word in buffer." t)
(global-set-key "\e$" 'ispell-word)
(autoload 'ispell-region "ispell"
  "Check the spelling of region." t)
(autoload 'ispell-buffer "ispell"
  "Check the spelling of buffer." t)
(autoload 'ispell-complete-word "ispell"
  "Look up current word in dictionary and try to complete it." t)
(autoload 'ispell-change-dictionary "ispell"
  "Change ispell dictionary." t)
(autoload 'ispell-message "ispell"
  "Check spelling of mail message or news post.")

;;;
;;;  Depending on the mail system you use, you may want to include these:
;;;
;;;  (add-hook 'news-inews-hook 'ispell-message)
;;;  (add-hook 'mail-send-hook  'ispell-message)
;;;  (add-hook 'mh-before-send-letter-hook 'ispell-message)

;;
;; highlight
;;

(setq query-replace-highlight t)

;;
;; Newline
;;

(setq next-line-add-newlines nil)


;;
;; Minibuffer
;;

;; (resize-minibuffer-mode)
(setq enable-recursive-minibuffers t)

;;
;; Dired
;;

(add-hook 'dired-load-hook
	  (function (lambda ()
		      (load "dired-x")
		      ;; Set dired-x variables here.  For example:
		      ;; (setq dired-guess-shell-gnutar "gtar")
		      ;; (setq dired-omit-files-p t)
		      ;; (setq dired-x-hands-off-my-keys nil)
		      )))

;;
;; Ps-print
;;

(autoload 'ps-print-buffer "ps-print"
  "Generate and print a PostScript image of the buffer..." t)

;;
;; This file provides MIME support for several Emacs message reading
;; packages.  This file has been designed with RMAIL in mind, but it
;; has also been tested with mh-e and VM.  It should work with most
;; other major modes as well.
;;

(add-hook 'rmail-show-message-hook 'rmime-format)
(add-hook 'rmail-edit-mode-hook    'rmime-cancel)
(setq rmail-output-file-alist '(("" rmime-cancel)))
(autoload 'rmime-format "rmime" "" nil)

(setq auto-mode-alist
      (append '(("\\.java$" . java-mode)
		) auto-mode-alist))

;;
;; bind insert-register to the old keys
;;

(define-key ctl-x-map "g" 'insert-register)

;;
;; Domain specific xemacs 21
;;

(load "~/.$FULLNAME/$DOMAIN/.emacs.27" t)

;;
;; start the server
;;

;; (server-start)


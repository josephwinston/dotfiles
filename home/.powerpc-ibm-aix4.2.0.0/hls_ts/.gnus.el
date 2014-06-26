;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.powerpc-ibm-aix4.2.0.0/hls_ts/.gnus.el#1 $
;;

(if running-emacs19
    (progn
      (autoload 'gnus "gnus" "Read network news." t)
      (autoload 'gnus-post-news "gnus" "Post a news." t)

      (setq gnus-use-cross-reference t)
      (setq gnus-use-followup-to t)
      (setq gnus-full-window t)
      (setq gnus-large-newsgroup 1000)
      (setq gnus-show-threads t)
      (setq gnus-thread-hide-subject t)
      (setq gnus-thread-hide-subtree nil)
      (setq gnus-thread-hide-killed t)
      (setq gnus-thread-ignore-subject nil)
      (setq gnus-thread-indent-level 2)
      (setq gnus-auto-select-first t)
      (setq gnus-auto-select-next nil)
      (setq nntp-maximum-request 1000)	; smaller means it starts up faster
      (setq gnus-distribution-list
	    '("local" "tx" "usa" "na" "world"))

      (setq gnus-use-generic-from t)

      (if (not running-emacs19)
	  (progn
	    (load "gnus-mark")

	    (define-key gnus-Subject-mode-map "@" 'gnus-Subject-mark-article)
	    (define-key gnus-Subject-mode-map "F" 'gnus-forward-marked-articles)
	    (define-key gnus-Subject-mode-map "\M-@" 'gnus-Subject-mark-regexp)

	    (defun gnus-reconnect() "Reconnect to the NNTP server from within GNUS"
	      (interactive)
	      (nntp-open-server gnus-nntp-server))
	    ))
	(if running-lucid
	    (setq nntp-maximum-request 100)
	  (setq nntp-maximum-request 1))
	))

(setq gnus-nntp-server "news.lgc.com")
(setq gnus-your-domain "lgc.com")
(setq gnus-your-organization "Landmark Graphics Corporation, Inc.")
;; (setq gnus-default-distribution "") ; default to world distribution,


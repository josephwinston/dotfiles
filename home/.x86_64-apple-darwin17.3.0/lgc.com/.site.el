;; -*- Emacs-Lisp -*-

;;
;; Fix "no access to tty (Bad file descriptor)"
;; See https://lists.gnu.org/archive/html/help-gnu-emacs/2004-08/msg00112.html
;;

(setq process-connection-type t)

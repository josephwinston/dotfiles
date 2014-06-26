;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.emacs.term.54.el#1 $
;;

(defun unbound-key ()
  "filler for compound keymaps"
  (interactive)
  (error "unbound-key"))

;; hack to get to work with xterm
(if (string-equal window-system "x")
    (progn
      
      (defvar xsun-map (make-sparse-keymap) "*Keymap for ESC-[ encoded keyboard")
      
      (define-key xsun-map "208z" 'unbound-key)		; R2
      (define-key xsun-map "209z" 'unbound-key)		; R3
      (define-key xsun-map "210z" 'unbound-key)		; R4
      (define-key xsun-map "211z" 'unbound-key)		; R5
      (define-key xsun-map "212z" 'unbound-key)		; R6
      (define-key xsun-map "213z" 'unbound-key)		; R6
      (define-key xsun-map "214z" 'beginning-of-buffer)	; R7
      (define-key xsun-map "216z" 'scroll-down)		; R9
      (define-key xsun-map "215z" 'previous-line)		; R8  (up-arrow)
      (define-key xsun-map "217z" 'backward-char)		; R10 (rt-arrow)
      (define-key xsun-map "219z" 'forward-char)		; R12 (dn-arrow)
      (define-key xsun-map "221z" 'next-line)		        ; R14 (lf-arrow)
      (define-key xsun-map "218z" 'recenter)                    ; R11
      (define-key xsun-map "220z" 'end-of-buffer)		; R13
      (define-key xsun-map "222z" 'scroll-up)		        ; R15
      (define-key xsun-map "-1z" 'unbound-key)		        ; Ins and Help 

      (define-key xsun-map "192z" 'unbound-key)		        ; L1
      (define-key xsun-map "193z" 'call-last-kbd-macro)	        ; L2
      ;;	(define-key xsun-map "193z" 'unbound-key)		        ; L2
      (define-key xsun-map "194z" 'unbound-key)		        ; L3
      (define-key xsun-map "195z" 'unbound-key)		        ; L4
      (define-key xsun-map "1963" 'unbound-key)		        ; L5
      (define-key xsun-map "197z" 'unbound-key)		        ; L6
      (define-key xsun-map "198z" 'unbound-key)		        ; L7
      (define-key xsun-map "199z" 'unbound-key)		        ; L8
      (define-key xsun-map "200z" 'unbound-key)		        ; L9
      (define-key xsun-map "201z" 'unbound-key)		        ; L10
      
      (define-key esc-map "[" xsun-map)		        ; Install xsun-map
      (define-key esc-map "[A" 'previous-line )		; R8
      (define-key esc-map "[B" 'next-line)		        ; R14
      (define-key esc-map "[C" 'forward-char)		        ; R12
      (define-key esc-map "[D" 'backward-char)		; R10
      (define-key esc-map "[[" 'backward-paragraph)	        ; the original esc-[

))

(if (string-equal window-system "x")
    (progn
      (x-set-foreground-color "white")
      (x-set-background-color "black")
      (x-set-cursor-color "red")
      (x-set-mouse-color "white")))
	

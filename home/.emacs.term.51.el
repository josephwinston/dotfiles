;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.emacs.term.51.el#1 $
;;

(defun my-suntool-map-hooks ()
  (interactive)
  (define-key suntool-map "bl" 'eval-current-buffer)		; Again L2
  (define-key suntool-map "dr" 'edebug-defun)                ;R4
  (define-key suntool-map "er" 'edebug-step-through)         ;R5
)

(defun my-sun-raw-map-hooks ()
  (interactive)
  (define-key sun-raw-map "210z" 'backward-page)		; R3
  (define-key sun-raw-map "213z" 'forward-page)		; R6
  (define-key sun-raw-map "214z" 'beginning-of-buffer)	; R7
  (define-key sun-raw-map "216z" 'scroll-down)		; R9
  (define-key sun-raw-map "218z" 'recenter)               ; R11
  (define-key sun-raw-map "220z" 'end-of-buffer)		; R13
  (define-key sun-raw-map "222z" 'scroll-up)		; R15
  (define-key sun-raw-map "193z" 'redraw-display)		; Again
  (define-key sun-raw-map "194z" 'list-buffers)		; Props
  (define-key sun-raw-map "195z" 'undo)			; Undo
  (define-key sun-raw-map "196z" 'ignore-key)		; Expose-down
  (define-key sun-raw-map "197z" 'sun-select-region)	; Put
  (define-key sun-raw-map "198z" 'ignore-key)		; Open-down
  (define-key sun-raw-map "199z" 'sun-yank-selection)	; Get
  (define-key sun-raw-map "200z" 'exchange-point-and-mark); Find
  (define-key sun-raw-map "201z" 'kill-region-and-unmark)	; Delete
  (define-key sun-raw-map "226z" 'scroll-down-in-place)	; t3
  (define-key sun-raw-map "227z" 'scroll-up-in-place)	; t4
  (define-key sun-raw-map "229z" 'shrink-window)		; t6
  (define-key sun-raw-map "230z" 'enlarge-window)		; t7
)

;; turn on the sun function keys if on a sun console
(if (string-equal term-type "sun")
    (progn
      (setq sun-esc-bracket t)
      ;; I don't know why I have to do the load
      (load "term/sun")
      ))

(setq suntool-map-hooks '(lambda () (my-suntool-map-hooks)))
(setq sun-raw-map-hooks '(lambda () (my-sun-raw-map-hooks)))


;; Set up the term-setup-hook
;; This is done to for edt-emulation and the 386i keyboard

(setq term-setup-hook '(lambda () (my-term-setup-hook)))

(defun my-term-setup-hook()
  (cond

   ((string-equal mach-type "i386")
    (load (concat term-file-prefix "386i") nil t)
    (global-unset-key "\e[")
    (global-set-key "\e[255z" 'num-lock)
    (num-lock)
    )

   ((string-equal term-type "vt100")
    
    ;; see if we are running xemacs on a sun
    (if (string-equal manufacturer "sun")
	(progn
	  (setq sun-esc-bracket t)
	  (load "term/sun"))

      ;; a old vt-100, but we can do edt emulation
      
      (edt-emulation-on))
    )
      
   
   ((or (string-equal term-type "vt200") (string-equal term-type "vt200-w"))
    ;; a vt-200 let's use all the keys
    (edt-emulation-on)
    (global-set-key "\e[" CSI-map)
    (define-key CSI-map "17~" 'xedit-mode-on)               ;F6
    (define-key CSI-map "18~" 'xedit-mode-off)              ;F7
    (define-key CSI-map "19~" 'edebug-defun)                ;F8
    (define-key CSI-map "20~" 'edebug-step-through)         ;F9
    (define-key CSI-map "29~" 'eval-current-buffer)         ;Do
    (define-key CSI-map "2~" 'yank)                         ;Insert
    (define-key GOLD-map "\e[2~"  'insert-register)         ;Gold Insert
    (define-key GOLD-map "\e[3~"  'copy-region-as-kill)     ;Gold Remove
    (define-key GOLD-map "\e[4~"  'copy-to-register)        ;Gold Select
    )

   )
)
					

;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.sparc-sun-solaris2.5.1/LDGO/.mode.el#1 $
;;

;;
;; for modula3
;; 

(autoload 'modula-3-mode  "modula3" "Modula 3 Editing Mode" t)

(setq auto-mode-alist
      (append '(("\\.i3$" . modula-3-mode)
		("\\.ig$" . modula-3-mode)
		("\\.m3$" . modula-3-mode)
		("\\.mg$" . modula-3-mode)
		) auto-mode-alist))

(add-hook 'm3::mode-hook  'turn-on-font-lock)

;;
;; Mode C++ stuff
;;

(setq auto-mode-alist
      (append '(("\\.conf$"  . makefile-mode)
		("\\.cf$" . makefile-mode)
		("\\.mk$" . makefile-mode)
		("\\.C\\.hdr$" . c++-mode)
		("\\.inl$" . c++-mode)
		) auto-mode-alist))


;;
;; Octave
;;

(autoload 'octave-mode "octave-mode" "Octave editing mode." t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))


(add-hook 'octave-mode-hook  'turn-on-font-lock)

;;
;; xrdb
;;

(autoload 'xrdb-mode "xrdb-mode" "xrdb editing mode." t)
(setq auto-mode-alist
      (cons '("\\.ad$" . xrdb-mode) auto-mode-alist))

;; (add-hook xrdb-mode-hook  'turn-on-font-lock)

;;
;; pdb
;;

;; (load-library "pdb.el")

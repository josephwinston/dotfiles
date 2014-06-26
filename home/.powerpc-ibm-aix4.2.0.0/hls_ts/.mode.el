;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.powerpc-ibm-aix4.2.0.0/hls_ts/.mode.el#1 $
;;

(setq auto-mode-alist
      (append '(("\\.conf$"  . makefile-mode)
		("\\.cf$" . makefile-mode)
		("\\.mk$" . makefile-mode)
		("\\.C\\.hdr$" . c++-mode)
		("\\.inl$" . c++-mode)
		) auto-mode-alist))


;;
;; Teleuse D
;;

(autoload 'd-mode   "d-mode" "D Mode" t)

(setq auto-mode-alist
      (append '(("\\.d$" . d-mode)) auto-mode-alist))

(defun my-d-mode-hook()
  (font-lock-mode 1)
  )

(add-hook 'd-mode-hook 'my-d-mode-hook)


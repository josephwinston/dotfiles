(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'cmake-mode "~/Tools/share/emacs/site-lisp/cmake-mode.el" t)

;;
;; scala
;;

(add-to-list 'load-path "~/Tools/share/emacs/site-lisp/scala")
(require 'scala-mode-auto)

(defun scala-turnoff-indent-tabs-mode ()
  (setq indent-tabs-mode nil))

;;
;; scala mode hooks
;;

(add-hook 'scala-mode-hook 'scala-turnoff-indent-tabs-mode)

;;
;; cedet -- Too slow
;;

;; (load "~/.$FULLNAME/$DOMAIN/.cedet" t)



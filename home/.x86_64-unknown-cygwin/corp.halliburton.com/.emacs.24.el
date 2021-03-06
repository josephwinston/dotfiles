;;
;; spelling
;;

(setq ispell-program-name "aspell")

;;
;; Set up for utf-8
;;

(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
;; From Emacs wiki
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; MS Windows clipboard is UTF-16LE 
(set-clipboard-coding-system 'utf-16le-dos)

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
;; .cu
;;

(setq auto-mode-alist
      (append
       '(("\\.cu\\'" . c++-mode))
       auto-mode-alist))

;;
;; cedet -- Too slow
;;

;; (load "~/.$FULLNAME/$DOMAIN/.cedet" t)


(autoload 'markdown-mode "~/Tools/share/emacs/site-lisp/markdown-mode/markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

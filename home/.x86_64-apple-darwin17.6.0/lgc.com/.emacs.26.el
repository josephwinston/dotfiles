;; -*- Emacs-Lisp -*-

;;
;; homeschick puts symbolic links for dotfile
;;

(setq vc-follow-symlinks t)

;;; When opening a file that is a symbolic link, don't ask whether I
;;; want to follow the link. Just do it
(setq find-file-visit-truename t)


;;
;; MELPA 
;;

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;
;; Fix "no access to tty (Bad file descriptor)"
;; See https://lists.gnu.org/archive/html/help-gnu-emacs/2004-08/msg00112.html
;;

(setq process-connection-type t)

;;
;; Old splitting mode
;;

(setq split-width-threshold nil)

;;
;; Set up bbdb
;;

;; (require 'bbdb)
;; (bbdb-initialize 'gnus 'message 'sc 'w3 'vm)

;;
;; Set up auctex
;;

;;
;; Enable parsing
;;

(setq TeX-auto-save t)			; Enable parse on load.
(setq TeX-parse-self t)			; Enable parse on save.
(setq-default TeX-master nil)

;;
;; Maximum decoration
;;

(setq font-lock-maximum-decoration t) 

;;
;; Add reftex
;;

(autoload 'turn-on-reftex "reftex")
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode

;;
;; Add bib-cite
;;

;; (autoload 'turn-on-bib-cite "bib-cite")
;; (add-hook 'LaTeX-mode-hook 'turn-on-bib-cite)
;; (add-hook 'latex-mode-hook 'turn-on-bib-cite)

;;
;; Adjust the default directory
;;

(if (equal default-directory "/") 
    (setq default-directory "~/")
  )
 
;;
;; Help the compiler parsing
;;

(setq process-connection-type nil)

;;
;; spellingx
;;

(setq ispell-program-name "/opt/local/bin/aspell")

;;
;; p4
;;

;; (load-library "p4")
;; (setq p4-executable "/usr/local/bin/p4")

(setq load-path (cons (expand-file-name "~/.emacs.d/elpa/cmake-mode-3.7.1") load-path))
(require 'cmake-mode)

;;
;; https://github.com/hvesalai/scala-mode2.git
;;

(add-to-list 'load-path "~/Tools/share/emacs/site-lisp/scala-mode2/")
(require 'scala-mode2)

;;
;; csharp
;;

(setq load-path (cons (expand-file-name "~/.emacs.d/elpa/csharp-mode-0.9.0") load-path))
  (autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
  (setq auto-mode-alist
     (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;;
;; cuda
;;

(setq auto-mode-alist
      (append '(("\\.cu" . c++-mode)) auto-mode-alist))

;;
;; python mode 
;;

;;(add-to-list 'load-path "~/.emacs.d/elpa/python-mode-20161124.930/") 
;;(setq py-install-directory "~/.emacs.d/elpa/python-mode-20161124.930/") 
;; (require 'python-mode)

(setq py-shell-name "/opt/local/bin/python2.7")


;;
;; Markdown
;;

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;
;; magit
;;

(global-set-key (kbd "C-x g") 'magit-status)

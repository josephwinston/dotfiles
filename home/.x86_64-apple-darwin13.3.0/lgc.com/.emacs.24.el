;; -*- Emacs-Lisp -*-

;;
;; MELPA Stable (https://github.com/milkypostman/melpa)
;;

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

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
;; csharp
;;

(autoload 'csharp-mode "~/Tools/share/emacs/site-lisp/csharp-mode-0.8.5" "Major mode for editing C# code." t)
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

(add-to-list 'load-path "~/Tools/share/emacs/site-lisp/python-mode.el-6.1.0/") 
(setq py-install-directory "~/Tools/share/emacs/site-lisp/python-mode.el-6.1.0/") 
(require 'python-mode)

(setq py-shell-name "/opt/local/bin/python2.7")

;;
;; clang and autocomplete need emacs 24.3 or later
;;

(add-to-list 'load-path "~/.x86_64-apple-darwin13.3.0/lgc.com/yasnippet")
(setq yas-snippet-dirs
      '("~/.x86_64-apple-darwin13.3.0/lgc.com/yasnippet/personal/snippets"            ;; personal snippets
        "~/.x86_64-apple-darwin13.3.0/lgc.com/yasnippet/snippets"    ;; the default collection
        ))
(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'load-path "~/.x86_64-apple-darwin13.3.0/lgc.com/auto-complete-1.3.1")
(add-to-list 'load-path "~/.x86_64-apple-darwin13.3.0/lgc.com/emacs-clang-complete-async") 

(defun ac-common-setup ()
  (setq ac-sources (append ac-sources '(ac-source-dictionary))))

(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.x86_64-apple-darwin13.1.0/lgc.com/emacs-clang-complete-async/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
)

;;
;; A smaller than normal delay
;;

(setq ac-delay 0.02)

;;
;; If you want to add parameters to clang (libclang, actually), such
;; as -Ipath, just call ac-clang-set-cflags interactively or set the
;; value of ac-clang-flags in .emacs or .dir-locals.el.
;;
;; You mightneed an explicit call to ac-clang-update-cmdlineargs to
;;  make changes to cflags take effect
;;

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

;;
;; Markdown
;;

(autoload 'markdown-mode "~/Tools/share/emacs/site-lisp/markdown-mode/markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


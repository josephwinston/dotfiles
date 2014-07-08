;;; ff-paths.el - find-file-using-paths searches certain paths to find files.

;; Copyright (C) 1994, 1995 Peter S. Galbraith
 
;; Author:    Peter S. Galbraith <rhogee@bathybius.meteo.mcgill.ca>
;; Created:   16 Sep 1994
;; Version:   2.01 (06 Jul 95)
;; Keywords:  find-file, paths, search

;; Everyone is granted permission to copy, modify and redistribute this
;; file provided:
;;   1. All copies contain this copyright notice.
;;   2. All modified copies shall carry a prominant notice stating who
;;      made modifications and the date of such modifications.
;;   3. The name of the modified file be changed.
;;   4. No charge is made for this software or works derived from it.
;;      This clause shall not be construed as constraining other software
;;      distributed on the same medium as this software, nor is a
;;      distribution fee considered a charge.

;; LCD Archive Entry:
;; ff-paths.el|Peter Galbraith|galbraith@mixing.qc.dfo.ca|
;; find-file-using-paths searches certain paths to find files|
;; 05-July-1995|2.00|~/misc/ff-paths.el.gz
;; ----------------------------------------------------------------------------
;;; Commentary:

;; New versions of this package (if they exist) may be found at:
;;   ftp://bathybius.meteo.mcgill.ca/pub/users/rhogee/elisp/ff-paths.el
;;   ftp://mixing.qc.dfo.ca/pub/emacs-add-ons/ff-paths.el

;; This code allows you to use C-x C-f normally most of the time, except that
;; if the requested file doesn't exist, it is checked against a list of 
;; patterns for special paths to search for a file of the same name.
;;
;; Examples:
;;  - a file extension of .bib will cause to search the path defined in 
;;    $BSTINPUTS or $BIBINPUTS for the file you requested.
;;  - a file extension of .h will cause the /usr/include/ and
;;    /usr/local/include/ directory trees to be searched.
;;  - a file extension of .sty causes a search of TEXINPUTS and of all 
;;    directories below /usr/lib/texmf/tex/
;;  - a file extension of .el causes a search of the path set in the
;;    emacs variable load-path.
;;
;; If a file (or many!) of the same name is found, then the *completions*
;; is displayed with all possibilities, including (listed first) the
;; non-existing path you first provided.  Selecting it creates the new file.
;;
;; If no file is found, you are prompted as to the creation of a new file.
;;
;; You can use (setq ff-paths-prompt nil) to *not* get that prompt if you 
;; wish, thus making it behave more like regular find-file.

;; The file patterns and paths can be modified by the user by editing the 
;; variable ff-paths-list defined below.

;; I suggest that you get ffap.el by Michelangelo Grigni <mic@cs.ucsd.edu>.  
;; His package will guess the filename from the text under the editing point.  
;; It will search for an existing file in various places before you even
;; get the "File: " prompt.  ff-paths.el is a good complement because it
;; acts after you've provided a filename (if there was nothing foe ffap to
;; find to start with).
;;   **HOWEVER** you must get a version dated Jan 30 1995 or later to be 
;;               compatible with ff-paths.el

;; Suggested use for this package is as C-x C-f to replace find-file 
;; (You could uncomment the next line to do so)
;;
;;       (define-key ctl-x-map "\C-f" 'find-file-using-paths)
;;
;; unless you also use ffap.el, in which case simply load this package before 
;; ffap.el and it will be smarth enough to know what to do.

;; ----------------------------------------------------------------------------
;;; Change log:
;;
;; V1.01  16sep94 - created by Peter S. Galbraith, 
;;                  rhogee@bathybius.meteo.mcgill.ca
;; V1.02  20sep94 - by Peter S. Galbraith 
;;      Change TeX-split-string to dired-split (thanks to Michelangelo Grigni)
;;      Change variable name psg-ff-list to ff-paths-list
;;      Added find-file-noselect-using-paths for ffap.el
;;      Added ff-paths-prompt variable
;; V1.03  12oct94 - by Peter S. Galbraith
;;      Fixed:
;;      - error when nil appeared in ff-paths-list translation 
;;        (meaning current default)
;;      - find-file-at-point would switch buffer if new file were not created.
;; V1.04  24oct94 - by Peter S. Galbraith
;;      Added patch from Ziv Gigus <ziv@sgi.com> to let environment variables
;;       have trailing directory paths:
;;            ("^foo_.*\\.[ch]$" "$FOO1:$FOO/bar:$FOO/barnone")
;; V2.00  05Jul95 - by Peter S. Galbraith
;;       Reworked interface
;;   Tremendous thanks to Bill Brodie <wbrodie@panix.com> for telling me how 
;;   to make completing-read start off with the completions buffer displayed.
;;   It made this version possible without a kludge.  Thanks Bill!
;; V2.01  05Jul95 - by Peter S. Galbraith
;;      - Followed Bill Brodie's suggestions to make ff-paths-list not
;;        necessarilly a colon-separated string, but rather usually a list
;;        of strings:    ("\\.bib$" "$BSTINPUTS:$BIBINPUTS")
;;                    -> ("\\.bib$" "$BSTINPUTS" "$BIBINPUTS")
;;      - Also his suggestion to not quote symbols.
;;      - Also his suggestion to include leftmost matches as initial string
;;        to completing-read.
;;      - Also, I substitute ~/ for the home directory if possible in the 
;;        matches displayed in the completions buffer. 
;; ----------------------------------------------------------------------------
;;; Code:

;; The following variables may be edited to suit your site: 

(defvar ff-paths-prompt t
  "If nil, find-file-using-paths will *not* prompt to create an empty buffer.")

;; Is it XEmacs?
(defconst ff-xemacs-p
  (string-match "\\(Lucid\\|XEmacs\\)" emacs-version))

(defvar ff-paths-list
  '(("\\.awk$" "$AWKPATH")              ; awk files in AWKPATH env variable.
    ("\\.bib$" "$BSTINPUTS" "$BIBINPUTS") ; bibtex files.
    ("\\.\\(sty\\|cls\\)$" "$TEXINPUTS" "/usr/lib/texmf/tex//") ;LaTeX files
    ("\\.[h]+$" "/usr/local/include//" "/usr/include//")
    ("^\\." "~/")                       ; .* (dot) files in user's home
    ("\\.el$" load-path))               ; el extension in load-path elisp var
  "*List of paths to search for given file extension regexp's.
The directories can be:
  - colon-separated directories and ENVIRONMENT variables 
    (which may also translate to colon-separated directories)
  - list of strings representing directories or environment variables.
  - a symbol object evaluating to a list of strings (e.g. load-path)

You may mix environment variables and directory paths together.
You may add trailing directoty paths to environment variables, e.g. $HOME/bin
You may not mix strings with elisp lists (like load-path).
You may terminate a directory name with double slashes // indicating that
 all subdirectories beneath it should also be searched.")

;; ----------------------------------------------------------------------------

(defun find-file-using-paths (filename)
  "Edit FILENAME. If file does not exist, prompt to create or search around
for the file in paths specified by the variable ff-paths-list."
  (interactive "FFind file: ")
  (if (file-exists-p filename)
      (switch-to-buffer (find-file-noselect filename))
    (let* ((the-name (file-name-nondirectory filename))
           (matches (psg-filename-in-directory-list 
                     the-name (psg-translate-ff-list the-name))))
      (if (null matches)
          (if (or (not ff-paths-prompt)
                  (yes-or-no-p (format "`%s' does not exist. Create? "  
                                       filename)))
              (switch-to-buffer (find-file-noselect filename)))
        (setq matches (psg-convert-homedir-to-tilde
                       (cons (expand-file-name filename) matches)))
        (let ((unread-command-char ??))
          (setq the-name 
                (or (and (string-equal "18" (substring emacs-version 0 2))
                         (completing-read "Find file: " 
                                          (create-alist-from-list matches) 
                                          nil 0
                                          (psg-common-in-list matches)))
                    (completing-read "Find file: " 
                                     (create-alist-from-list matches) 
                                     nil 0
                                     (psg-common-in-list matches)
                                     'file-name-history))))
        (if (and the-name
                 (not (string-equal "" the-name)))
            (switch-to-buffer (find-file-noselect the-name)))))))

;; There must be a minibuffer command to do this!
(defun psg-common-in-list (list)
  "returns STRING with same beginnings in all strings in LIST"
  (let* ((first-string (car list)) 
         (work-list (cdr list))
         (match-len (length first-string)))
    (while work-list
      (let ((i 1))
        (while (and (<= i match-len)
                    (<= i (length (car work-list)))
                    (string-equal (substring first-string 0 i) 
                                  (substring (car work-list) 0 i))
                    (setq i (1+ i))))
        (setq match-len (1- i)))
      (setq work-list (cdr work-list)))
    (substring first-string 0 match-len)))

(defun psg-convert-homedir-to-tilde (list)
  (let* ((work-list list)(result-list)
         (homedir (concat "^" (file-name-as-directory 
                               (expand-file-name "~"))))
         (the-length (1- (length homedir))))
    (while work-list
      (if (string-match homedir (car work-list))
          (setq result-list 
                (cons (concat "~/" (substring (car work-list) the-length)) 
                      result-list))
        (setq result-list (cons (car work-list) result-list)))
      (setq work-list (cdr work-list)))
    (nreverse result-list)))
    
;; Defined in bib-cite.el !
(defun create-alist-from-list (the-list)
  (let ((work-list the-list)(the-alist))
    (setq the-alist (list (list (car work-list))))
    (setq work-list (cdr work-list))
    (while work-list
      (setq the-alist (append the-alist (list (list (car work-list)))))
      (setq work-list (cdr work-list)))
    the-alist))

(defun psg-filename-in-directory-list (filename list)
  "Check for presence of FILENAME in directory LIST. Return all found.
If none found, recurse through directory tree of directories ending in //
and return all matches."
  ;;USAGE: (psg-checkfor-file-list "gri.cmd" (psg-list-env "PATH"))
  ;;USAGE: (psg-checkfor-file-list "gri-mode.el" load-path)
  ;;USAGE: (psg-checkfor-file-list "gri.cmd" (psg-translate-ff-list "gri.tmp"))
  (let ((the-list list) (filespec-list))
    (while the-list
      (let* ((directory (or (and (not (car the-list)) ; list item is nil -> ~/
                                 "~/")
                            (substring (car the-list) 
                                       0 
                                       (string-match "//$" (car the-list)))))
             ;; This removed trailing // if any
             (filespec (expand-file-name filename directory)))
        (if (file-exists-p filespec)
            (setq filespec-list (cons filespec filespec-list))))
      (setq the-list (cdr the-list)))
    (if filespec-list
        filespec-list
      ;; If I have not found a file yet, then check if some directories
      ;; ended in // and recurse through them.
      (let ((the-list list))
        (while the-list
          (if (not (string-match "//$" (car the-list))) nil
            (message "Searching directories %s for %s" (car the-list) filename)
            (setq filespec-list 
                  (append
                   filespec-list
                   (search-directory-tree 
                    (substring (car the-list) 0 (match-beginning 0)) 
                    (concat "^" filename "$") 
                    t))))
          (setq the-list (cdr the-list))))
      filespec-list)))
      
;;; search-directory-tree is heavily based on TeX-search-files
;;  which recursively searches a list of directories for files
;;  matching a list of extensions.  This simplified version should
;;  be a wee bit faster and will suit my purposes (for bib-cite's
;;  need to search directories listed in BIBINPUTS recursively 
;;  if they end in //).
;;  TeX-search-files is part of auc-tex:
;;    Maintainer: Per Abrahamsen <auc-tex@iesd.auc.dk>
;;    Version: $Id: //depot/Jody/main/jody/Tools/share/emacs/site-lisp/ff-paths.el#1 $
;;    Keywords: wp
     
;;    Copyright (C) 1985, 1986 Free Software Foundation, Inc.
;;    Copyright (C) 1987 Lars Peter Fischer
;;    Copyright (C) 1991 Kresten Krab Thorup
;;    Copyright (C) 1993, 1994 Per Abrahamsen 

(defun search-directory-tree (directories extension-regexp recurse)
  "Return a list of all reachable files in DIRECTORIES ending with EXTENSION.
DIRECTORIES is a list or a single-directory string
EXTENSION is actually (any) regexp, usually \\\\.bib$
If RECURSE is t, then we will recurse into the directory tree, 
              nil, we will only search the list given."
  (or (listp directories)
      (setq directories (list directories)))

  (let (match)
    (while directories
      (let* ((directory (file-name-as-directory  (car directories)))
             (content (and directory
			   (file-readable-p directory)
			   (file-directory-p directory)
			   (directory-files directory))))
        (setq directories (cdr directories))
        (while content
          (let ((file (concat directory (car content))))
            (cond ((string-match "/[.]+$" file)) 
                  ((not (file-readable-p file)))
                  ((file-directory-p file)
                   (if recurse
                       (setq directories
                             (cons (concat file "/") directories))))
                  ((string-match extension-regexp 
                                 (file-name-nondirectory file))
                   (setq match (cons file match)))))
          (setq content (cdr content)))))
    
    match))

(defun psg-translate-ff-list (filename)
  "Given a file name, return corresponding directory list from ff-paths-list
or nil if file name extension is not listed in ff-paths-list.
So translate the cdr of the ff-paths-list entry to a directory list.
NOTE: returned nil means no match, but nil as an element of the returned list
      is valid, meaning current-directory!"
  (let ((local-ff-list ff-paths-list)(unexpanded-path))
    (while local-ff-list
      (let ((the-pair (car local-ff-list)))
        (cond ((string-match (car the-pair) filename)
               (setq unexpanded-path (cdr the-pair))
               (setq local-ff-list nil)))
        (setq local-ff-list (cdr local-ff-list))))
    ;; `unexpanded-path' holds a list of:
    ;;    no match          ->  nil
    ;;    symbol            ->  (load-path) 
    ;;    stringed PATH     ->  ("/usr/local/include//:/usr/include//")
    ;;    many such strings ->  ("/usr/local/include//" "/usr/include//")
    ;;    appended env var  ->  ("$FOO/bar")
    (cond 
     ((not unexpanded-path)             ; nil case, and we're done.
      nil)
     ((symbolp (car unexpanded-path))   ; load-path type symbol
      (eval (car unexpanded-path)))     ; ->Return it, and we're done.
     (t                                 ;string case, expand each element
      (let ((the-list))
        (while unexpanded-path
          (let ((the-elements (dired-split ":" (car unexpanded-path)))
                (path-list) (element))
            (while the-elements
              (setq element (car the-elements))
              (setq the-elements (cdr the-elements))
              (if (string-match "^\\$" element) ; an ENVIRONMENT var?
                  (setq path-list 
                        (nconc path-list (psg-list-env (substring element 1))))
                (if (file-directory-p element) ;  Add only if it exists
                    (setq path-list (cons element path-list)))))
            (if path-list
                (setq the-list (append path-list the-list))))
          (setq unexpanded-path (cdr unexpanded-path)))
        the-list)))))                   ; return full path list. Done...

;;; load dired stuff of GNU Emacs.  Since dired-aux.el (at least up to GNU
;;; Emacs 19.22) does not `provide' itself, we do it here.  This avoids the
;;; possibility recursive loading because of the nasty `eval-when-compile' that
;;; is in dired-aux.el.
;;; But don't load it if we can use auc-tex's own TeX-split-string
;;; (this seems weird, but I use psg-list-env for bib-cite, for auc-tex)

(and (not (featurep 'tex))
     (not (featurep 'dired-aux))
     (not ff-xemacs-p)
     (load "dired-aux" nil t)
     (not (featurep 'dired-aux))
     (provide 'dired-aux))

(defun psg-list-env (env)
  "Return a list of directory elements in ENVIRONMENT variable (w/o leading $)
argument may consist of environment variable plus a trailing directory, e.g.
HOME or HOME/bin"
  (let* ((slash-pos (string-match "/" env))
         (value (if (not slash-pos)
                    (getenv env)
                  (concat (getenv (substring env 0 slash-pos))
                          (substring env slash-pos))))
         ;;(value (getenv env))
	 (entries (and value 
                       (or (and (fboundp 'TeX-split-string)
                                (TeX-split-string ":" value))
                           (dired-split ":" value))))
	 entry
	 answers) 
    (while entries
      (setq entry (car entries))
      (setq entries (cdr entries))
      (if (file-directory-p entry)
	  (setq answers (cons entry answers))))
    (nreverse answers)))

(provide 'ff-paths)
;;; ff-paths.el ends here

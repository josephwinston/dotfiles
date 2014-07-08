;; This file is part of GNU Emacs.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY.  No author or distributor
;; accepts responsibility to anyone for the consequences of using it
;; or for whether it serves any particular purpose or works at all,
;; unless he says so in writing.  Refer to the GNU Emacs General Public
;; License for full details.

;; Everyone is granted permission to copy, modify and redistribute
;; GNU Emacs, but only under the conditions described in the
;; GNU Emacs General Public License.   A copy of this license is
;; supposed to have been given to you along with GNU Emacs so you
;; can know your rights and responsibilities.  It should be in a
;; file named COPYING.  Among other things, the copyright notice
;; and this notice must be preserved on all copies.

;;; Header: /usr2hao/teleuse/sun4_4_1/base/uimsfn/RCS//d-mode.el,v 1.1 92/11/26 17:03:55 johan Exp Locker: johan $

;;-------------------------------------------------------------------
;; A D-language indentation and documentation search library
;;-------------------------------------------------------------------
;;
;; Written by Leif Larsson, ll@linkoping.trab.se
;; Started:	26 Sept 91
;; Version:	1.4
;;
;; Changed:	3 Dec 91	by Leif Larsson
;; Version:	1.2
;;	Bug:	Strings ('', "") starting within a D-specific comment
;;		wasn't ignored.
;;	Fix:	Extra indentation for continued statements supplied.
;;
;; Changed:	3 Dec 91	by Leif Larsson
;; Version:	1.3
;;	Bug:	Line after else and elsif was treated as continued
;;		statement.
;;
;; Changed:	3 Dec 91	by Leif Larsson
;; Version:	1.4
;;	Bug:	Line after elsif still was treated as continued
;;		statement.
;;
;; Changed:	3 Dec 91	by Leif Larsson
;; Version:	1.5
;;	Bugfix:	Single quote character in a D-specific comment would
;;		make parse-partial-sexp go boink the next time such a
;;		quote showed up. This was fixed by making parse-partial-sexp
;;		only parse up to the nearest D-comment each time and then
;;		skip the comment before continuing parsing.
;;
;; Changed:	10 Dec 91	by Leif Larsson
;; Version:	1.6
;;	Bug:	The last fix introduced the problem that if one had a --
;;		inside a string the end of the string would be skipped
;;		erroneously.
;;
;; Changed:	11 Dec 91	by Leif Larsson
;; Version:	1.7
;;	Bugfix:	An if or while statement with a string within isn't
;;		recognized as the beginning of a block. The fix was to
;;		change the constant d-mode-block-delimiters-re so that
;;		it doesn't try to match the whole "if-then" and "while-do"
;;		constructsbut only "if" and "while" without any trailing
;;		";" as in "end if ;" and "end while ;".
;;
;; Documentation: See d-mode (^HF d-mode)
;;-------------------------------------------------------------------


(defvar d-mode-abbrev-table nil
  "Abbrev table in use in D-mode buffers.")
(define-abbrev-table 'd-mode-abbrev-table ())

(defvar d-mode-map ()
  "Keymap used in D mode.")
(if d-mode-map
    ()
  (setq d-mode-map (make-sparse-keymap))
;;  (define-key d-mode-map "\e\C-h" 'mark-d-rule)
  (define-key d-mode-map "\177" 'backward-delete-char-untabify)
  (define-key d-mode-map "\t" 'd-mode-indent-command))

(defvar d-mode-syntax-table nil
  "Syntax table in use in D-mode buffers.")

(if d-mode-syntax-table
    ()
  (setq d-mode-syntax-table (make-syntax-table))
  (modify-syntax-entry ?\\ "\\" d-mode-syntax-table)
  (modify-syntax-entry ?/ ". 14" d-mode-syntax-table)
  (modify-syntax-entry ?* ". 23" d-mode-syntax-table)
  (modify-syntax-entry ?+ "." d-mode-syntax-table)
  (modify-syntax-entry ?- "." d-mode-syntax-table)
  (modify-syntax-entry ?= "." d-mode-syntax-table)
  (modify-syntax-entry ?% "." d-mode-syntax-table)
  (modify-syntax-entry ?< "." d-mode-syntax-table)
  (modify-syntax-entry ?> "." d-mode-syntax-table)
  (modify-syntax-entry ?& "." d-mode-syntax-table)
  (modify-syntax-entry ?| "." d-mode-syntax-table)
  (modify-syntax-entry ?\' "\"" d-mode-syntax-table))

(defconst d-mode-indent-level 2
  "*Indentation of D statements with respect to containing block.")
(defconst d-mode-rule-indent-level 8
  "*Indentation of D rules relative the beginning of the line.")
(defconst d-mode-declaration-indent-level 8
  "*Indentation of D declarations relative the beginning of the line.")
(defconst d-mode-continued-statement-offset 8
  "*Extra indent for lines not starting new statements.")

(defconst d-mode-tab-always-indent t
  "*Non-nil means TAB in D mode should always reindent the current line,
regardless of where in the line point is when the TAB command is used.")


;; Set the regexp for matching filename/linenumber in a compilation log.
;; The error messages from the D-compiler is similar to SUN's cc messages,
;; so the regexp matching these cc messages can almost be used. However,
;; the ", line " part of the cc message corresponds to " line " for D, so
;; by making that differing comma optional (",? line ") the regexp can
;; also match D-compiler error messages.
;; For information: The compile.el code either has or will execute a
;; defvar defining this variable. If it hasn't yet it doesn't matter as
;; the defvar construct doesn't redefine an already defined value, it
;; just adds the documentation string.
(setq compilation-error-regexp
   "\\([^ :\n]+\\(: *\\|,? line \\|(\\)[0-9]+\\)\\|\\([0-9]+ *of *[^ \n]+\\)")

(defun d-mode ()
  "Major mode for editing D code.
Tab indents for D code.
Comments are delimited with /* ... */ or -- ... newline.
Paragraphs are equivalent to D-rules.
Delete converts tabs to spaces as it moves back.
\\{d-mode-map}
Variables controlling indentation style:
 d-mode-tab-always-indent
    Non-nil means TAB in D mode should always reindent the current line,
    regardless of where in the line point is when the TAB command is used.
 d-mode-indent-level
    Indentation of D statements within surrounding block. A block is a
    rule, an if, or an while statement. The surrounding block's indentation
    is the indentation of the line on which the does, if, or while statement
    appear.
 d-mode-declaration-indent-level
    Indentation of lines within declaration sections, excluding the line
    with the declaration header (eg locals:).
 d-mode-rule-indent-level
    Indentation of D rules. This is done relative the beginning of the
    line and will be the base for futher indentation within the rule.
 d-mode-continued-statement-offset
    Extra indentation given to lines continuing a statement.

Turning on D mode calls the value of the variable d-mode-hook with no args,
if that value is non-nil."
  (interactive)
  (kill-all-local-variables)
  (use-local-map d-mode-map)
  (setq major-mode 'd-mode)
  (setq mode-name "D")
  (setq local-abbrev-table d-mode-abbrev-table)
  (set-syntax-table d-mode-syntax-table)
  (make-local-variable 'paragraph-start)
  (setq paragraph-start "^[^\n]*does")
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'paragraph-ignore-fill-prefix)
  (setq paragraph-ignore-fill-prefix t)
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'd-mode-indent-line)
  (make-local-variable 'require-final-newline)
  (setq require-final-newline t)
  (make-local-variable 'comment-start)
  (setq comment-start "-- ")
  (make-local-variable 'comment-end)
  (setq comment-end "")
  (make-local-variable 'comment-column)
  (setq comment-column 32)
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "\\(/\\*+\\|--\\) *")
  (make-local-variable 'comment-indent-hook)
  (setq comment-indent-hook 'd-mode-comment-indent)
  (make-local-variable 'parse-sexp-ignore-comments)
  (setq parse-sexp-ignore-comments t)
  (run-hooks 'd-mode-hook))

;; This is used by indent-for-comment
;; to decide how much to indent a comment in D code
;; based on its context.
(defun d-mode-comment-indent ()
  (if (looking-at "^\\(/\\*\\|--\\)")
      0					;Existing comment at bol stays there.
    (save-excursion
      (skip-chars-backward " \t")
      (max (1+ (current-column))	;Else indent at comment column
	   comment-column))))		;except leave at least one space.

(defun d-mode-inside-parens-p ()
  (condition-case ()
      (save-excursion
	(save-restriction
	  (narrow-to-region (point)
			    (progn (beginning-of-defun) (point)))
	  (goto-char (point-max))
	  (= (char-after (or (scan-lists (point) -1 1) (point-min))) ?\()))
    (error nil)))


;; Some usefule constants for defining regular expressions.
(defconst re-word-begin "\\<"
  "*Constant for the regexp construct which matches the beginning of a word.")
(defconst re-word-end "\\>"
  "*Constant for the regexp construct which matches the end of a word.")
(defconst re-or "\\|"
  "*Constant for the regexp construct specifying an alternative.")

(defun d-mode-indent-command (&optional whole-exp)
  (interactive "P")
  "Indent current line as D code, or in some cases insert a tab character.
If d-mode-tab-always-indent is non-nil (the default), always indent current
line. Otherwise, indent the current line only if point is at the left margin
or in the line's indentation; otherwise insert a tab.

A numeric argument, regardless of its value,
means indent rigidly all the lines of the expression starting after point
so that this line becomes properly indented.
The relative indentation among the lines of the expression are preserved."
  (if whole-exp
      ;; If arg, always indent this line as D
      ;; and shift remaining lines of expression the same amount.
      (let ((shift-amt (d-mode-indent-line))
	    beg end)
	(save-excursion
	  (if d-mode-tab-always-indent
	      (beginning-of-line))
	  (setq beg (point))
	  (forward-sexp 1)
	  (setq end (point))
	  (goto-char beg)
	  (forward-line 1)
	  (setq beg (point)))
	(if (> end beg)
	    (indent-code-rigidly beg end shift-amt "#")))
    (if (and (not d-mode-tab-always-indent)
	     (save-excursion
	       (skip-chars-backward " \t")
	       (not (bolp))))
	(insert-tab)
      (d-mode-indent-line))))

(defun d-mode-indent-line ()
  "Indent current line as D code.
Return the amount the indentation changed by."
  (let ((indent (calculate-d-mode-indent nil))
	beg shift-amt
	(case-fold-search nil)
	(pos (- (point-max) (point))))
    (beginning-of-line)
    (setq beg (point))
    (cond ((eq indent nil)
	   (setq indent (current-indentation)))
	  ((eq indent t)
	   (setq indent (calculate-d-mode-indent-within-comment)))
	  ((looking-at "[ \t]*#")
	   (setq indent 0))
	  ((looking-at "[ \t]*--")
	   (setq indent (current-indentation)))
	  (t
	   (if (listp indent) (setq indent (car indent)))))
    (skip-chars-forward " \t")
    (setq shift-amt (- indent (current-column)))
    (if (zerop shift-amt)
	(if (> (- (point-max) pos) (point))
	    (goto-char (- (point-max) pos)))
      (delete-region beg (point))
      (indent-to indent)
      ;; If initial point was within line's indentation,
      ;; position after the indentation.  Else stay at same point in text.
      (if (> (- (point-max) pos) (point))
	  (goto-char (- (point-max) pos))))
    shift-amt))

(defun calculate-d-mode-indent (&optional parse-start)
  "Return appropriate indentation for current line as D code.
In usual case returns an integer: the column to indent to.
Returns nil if line starts inside a string, t if in a comment."
  (save-excursion
    (beginning-of-line)
    (let ((indent-point (point))
	  (case-fold-search nil)
	  (state nil)
	  containing-sexp)
      (if parse-start
	  (goto-char parse-start)
	(goto-char (point-min)))
      (setq parse-start (point))
      (setq state (parse-partial-sexp parse-start
				      (d-mode-next-d-comment indent-point)))
      (while (< (point) indent-point)
	;; Point is now at a possible D-comment start.
	(cond ((nth 4 state)
	       ;; The D-comment start is part of a cpp-comment. Skip up to
	       ;; the end of the cpp-comment and continue parsing.
	       (d-mode-skip-cpp-comment-forwards)
	       (forward-char -2))
	      ((nth 3 state)
	       ;; The D-comment start is part of a string. Skip up to
	       ;; the end of the string and continue parsing.
	       (re-search-forward (concat "[^\\]"
					  (char-to-string (nth 3 state)))
				  indent-point 'move)
	       (forward-char -1))
	      (t
	       ;; We have got a real D-comment. Skip to the end of the
	       ;; comment, that is the end of the line, and continue parsing.
	       (end-of-line)))
	(setq state (parse-partial-sexp (point)
					(d-mode-next-d-comment indent-point)
					nil nil state)))
      (setq containing-sexp (car (cdr state)))
      (cond ((or (nth 3 state) (nth 4 state))
	     ;; Inside comment or string.
	     ;; Return t if inside comment and nil if inside string.
	     ;; Comment has precedence over string.
	     (if (nth 4 state)
		 t
	       ;; Inside string, but the beginning of the string could
	       ;; be inside D-specific comment, in which case the
	       ;; indentation line should be considered a normal line.
	       (goto-char indent-point)
	       (if (re-search-backward (concat "[^\\]"
					       (char-to-string (nth 3 state)))
				       (point-min))
		   (forward-char 1))
	       (if (d-mode-inside-d-comment)
		   (calculate-d-mode-statement-indent indent-point)
		 nil)))
	    (containing-sexp
	     ;; Line is expression, not statement:
	     ;; indent to just after the surrounding open.
	     (goto-char (1+ containing-sexp))
	     (skip-chars-forward " \t")
	     (current-column))
	    (t
	     ;; Statement, declaration, or top level.
	     (calculate-d-mode-statement-indent indent-point))))))


(defconst d-mode-cpp-comment-re
  (concat "/\\*" re-or "\\*/")
  "*Constant-string holding the regular expression matching either the
beginning or end of a cpp comment.")

(defconst d-mode-skip-area-start-re
  (concat "--" re-or "/\\*" re-or "\"")
  "*Constant-string holding the regular expression matching a construct
starting a skip area like a string or comment")

(defconst d-mode-skip-area-end-re
  (concat "\\*/" re-or "\"")
  "*Constant-string holding the regular expression matching a construct
ending a skip area like a string or comment (-- ... <newline> not included)")


(defun d-mode-skip-cpp-comment-forwards (&optional lim)
  "Move point to the end of the current cpp comment."
  (search-forward "*/" lim 'move))


(defun d-mode-skip-cpp-comment-backwards ()
  "Move point to the beginning of the current cpp comment."
  (let ((searching t)
	(current-candidate-point nil))
    (while searching
      (if (not (re-search-backward d-mode-cpp-comment-re (point-min) 'move))
	  (setq searching nil)
	(if (looking-at "\\*/")
	    (setq searching nil)
	  (setq current-candidate-point (point)))))
    (if current-candidate-point
	(goto-char current-candidate-point))))


(defun d-mode-skip-d-comment-backwards ()
  "Move point to the beginning of the current D-comment."
  (let ((searching t)
	(current-candidate-point nil))
    (while searching
      (if (not (search-backward "--"
				(save-excursion (beginning-of-line) (point))
				t))
	  (setq searching nil)
	(setq current-candidate-point (point))))
	(forward-char 1)		; Handles "---" situation
    (if current-candidate-point
	(goto-char current-candidate-point))))


(defun d-mode-skip-string-backwards ()
  "Move point to the beginning of the current string. Handles quoted
double-quotes."
  (if (re-search-backward "[^\\]\"" (point-min) 'move)
      (forward-char 1)))


(defun d-mode-next-d-comment (&optional lim)
  "Return the position of the next D-comment. If optional argument LIMIT is
non-nil that position will be returned if no D-comment is found before."
  (save-excursion
    (if (search-forward "--" lim 'move)
	(forward-char -2))
    (point)))


(defconst d-mode-section-headers-re
  (concat re-word-begin "dmodule" re-word-end re-or
	  re-word-begin "accepts:" re-or
	  re-word-begin "sends:" re-or
	  re-word-begin "flags:" re-or
	  re-word-begin "locals:" re-or
	  re-word-begin "imports:" re-or
	  re-word-begin "calls:" re-or
	  re-word-begin "devents:" re-or
	  re-word-begin "rules:" re-or
	  re-word-begin "does" re-word-end re-or
	  d-mode-skip-area-end-re)
  "*Constant-string holding the regular expression for searching for the
keywords involved in defining sections.")

(defun calculate-d-mode-statement-indent (indent-point)
  "Return appropriate indentation for the line of indent-point."
  (let ((case-fold-search nil)
	(searching t))
    ;; Find what section the point is in.
    ;; Do this by searching backwards until a declaration statement,
    ;; a does word, or the dmodule word appears.
    (goto-char indent-point)
    (while searching
      (if (re-search-backward d-mode-section-headers-re (point-min) 'move)
	    ;; One of the section headers was found and point is at the
	    ;; beginning of that header word. However the "header word"
	    ;; can be the end of a comment or string so we have to check
	    ;; for that and in such cases skip the area and continue
	    ;; searching.
	  (cond ((looking-at "\\*/")
		 (d-mode-skip-cpp-comment-backwards))
		((looking-at "\"")
		 (d-mode-skip-string-backwards))
		(t
		 ;; Point can still be inside a D comment.
		 (if (d-mode-inside-d-comment)
		     (d-mode-skip-d-comment-backwards)
		   (setq searching nil))))
	;; No section header was found so indent-point must be before
	;; the module header.
	(setq searching nil)))
    (if (= (point) (point-min))
	;; No section header was found or the "dmodule" statement was found.
	0
      ;; A section header starts at point. Figure out which header.
      (cond ((looking-at "does")
	     (calculate-d-mode-rule-statement-indent indent-point (point)))
	    ((looking-at "dmodule")
	     0)
	    ((looking-at "rules:")
	     d-mode-rule-indent-level)
	    (t
	     d-mode-declaration-indent-level)))))


(defun calculate-d-mode-rule-statement-indent (indent-point lim)
  "Return appropriate indentation for the rule line of indent-point. The
point is required to lie somewhere after the first does-word."
  (let (indent)
    ;; Find out what indentation the line should have according to the
    ;; surrounding block.
    (goto-char indent-point)
    (if (d-mode-backward-to-start-of-block lim)
	;; Inside if or while block.
	(if (d-mode-continued-statement-line-p indent-point (point))
	    (setq indent (+ (current-indentation)
			    d-mode-indent-level
			    d-mode-continued-statement-offset))
	  (setq indent (+ (current-indentation) d-mode-indent-level)))
      (if (<= (point) lim)
	  ;; Top level statement within a rule.
	  (if (d-mode-continued-statement-line-p indent-point (point))
	      (setq indent (+ d-mode-rule-indent-level
			      d-mode-indent-level
			      d-mode-continued-statement-offset))
	    (setq indent (+ d-mode-rule-indent-level d-mode-indent-level)))
	;; Outside rule.
	(setq indent d-mode-rule-indent-level)))
    ;; If the line is a clean closing line, that is it start with an end,
    ;; it should have the same indentation as the start of the block.
    ;; The same is true for line starting with else or elsif.
    (goto-char indent-point)
    (beginning-of-line)
    (skip-chars-forward " \t")
    (- indent
       (if (or (looking-at "end\\b")
	       (looking-at "else\\b")
	       (looking-at "elsif\\b"))
	   d-mode-indent-level
	 0))))


(defun d-mode-continued-statement-line-p (point-in-line block-point)
  "Return non-nil if current line continues the statement of the
previous line."
  (save-excursion
    (goto-char point-in-line)
    (beginning-of-line)
    (let ((searching t)
	  point-of-interest
	  state)
      (while searching
	(skip-chars-backward " \t\n")
	(cond ((save-excursion (backward-char 2) (looking-at "\\*/"))
	       (backward-char 2)
	       (d-mode-skip-cpp-comment-backwards))
	      ((d-mode-inside-d-comment)
	       (setq point-of-interest (point))
	       (d-mode-skip-d-comment-backwards)
	       (setq state (parse-partial-sexp (point-min) (point)))
	       (if (or (nth 3 state) (nth 4 state))
		   ;; The D-comment was inside a cpp-comment or a string.
		   (progn
		     (goto-char point-of-interest)
		     (setq searching nil))))
	      (t
	       (setq searching nil)))))
    (and (not (d-mode-points-in-same-line block-point (point)))
	 (not (save-excursion (forward-word -1) (or (looking-at "else")
						    (looking-at "then"))))
	 (not (eq (preceding-char) ?;)))))


;; This one can't handle strings within "if-then" and "while-do" statements.
;; It will match the skip-area end construct before it matches the
;; statement and when it has done so it has gone past the "then" or "do" word.
;; The less strict search criteria below should be enough.
;;(defconst d-mode-block-delimiters-re
;;  (concat re-word-begin "if" re-word-end "[^;]*"
;;	  re-word-begin "then" re-word-end
;;	  re-or
;;	  re-word-begin "while" re-word-end "[^;]*"
;;	  re-word-begin "do" re-word-end
;;	  re-or
;;	  re-word-begin "end" re-word-end
;;	  re-or
;;	  d-mode-skip-area-end-re)
;;  "Constant-string holding the regular expression for searching for the
;;keywords involved in defining blocks of statements.")


;; 
(defconst d-mode-block-delimiters-re
  (concat re-word-begin "if" re-word-end "[ \t]*[^;]" re-or
	  re-word-begin "while" re-word-end "[ \t]*[^;]" re-or
	  re-word-begin "end" re-word-end re-or
	  d-mode-skip-area-end-re)
  "Constant-string holding the regular expression for searching for the
keywords involved in defining blocks of statements.")


(defun d-mode-backward-to-start-of-block (lim)
  "Move point backward to the start of the block (if or while). Return
T if a start line was found within lim otherwise return nil."
  (let ((block-level 1)
	(inside-rule t))
    (beginning-of-line)
    (while (and (> block-level 0) (> (point) lim))
      (re-search-backward d-mode-block-delimiters-re lim 'move)
      (cond ((looking-at "\\*/")
	     (d-mode-skip-cpp-comment-backwards))
	    ((looking-at "\"")
	     (d-mode-skip-string-backwards))
	    (t
	     (if (not (d-mode-inside-d-comment lim))
		 (cond ((looking-at "if")
			(setq block-level (1- block-level)))
		       ((looking-at "while")
			(setq block-level (1- block-level)))
		       ((looking-at "end[ \t]*if")
			(setq block-level (1+ block-level)))
		       ((looking-at "end[ \t]*while")
			(setq block-level (1+ block-level)))
		       ((looking-at "end")
			(setq inside-rule nil)
			(setq block-level 0)))))))
    (and inside-rule (> (point) lim))))


(defun d-mode-inside-d-comment (&optional lim)
  "Returns non-nil if point is inside a D-specific comment."
  (save-excursion
    (if lim
	(setq lim (max lim (save-excursion (beginning-of-line) (point))))
      (setq lim (save-excursion (beginning-of-line) (point))))
    (search-backward "--" lim t)))


(defun d-mode-points-in-same-line (p1 p2)
  "T if the two args (integers) points to the same line"
  (if (not (and (integerp p1) (integerp p1)))
      nil)
  (save-excursion
    (let (line-begin)
      (goto-char p1)
      (beginning-of-line)
      (setq line-begin (point))
      (goto-char p2)
      (beginning-of-line)
      (= line-begin (point)))))


(defun calculate-d-mode-indent-within-comment ()
  "Return the indentation amount for line, assuming that
the current line is to be regarded as part of a block comment."
  (let (end star-start)
    (save-excursion
      (beginning-of-line)
      (skip-chars-forward " \t")
      (setq star-start (= (following-char) ?\*))
      (skip-chars-backward " \t\n")
      (setq end (point))
      (beginning-of-line)
      (skip-chars-forward " \t")
      (and (re-search-forward "/\\*[ \t]*" end t)
	   star-start
	   (goto-char (1+ (match-beginning 0))))
      (current-column))))



;;(defun mark-d-rule ()
;;  "Put mark at end of D rule, point at beginning."
;;  (interactive)
;;  (push-mark (point))
;;  (end-of-defun)
;;  (push-mark (point))
;;  (beginning-of-defun)
;;  (backward-paragraph))

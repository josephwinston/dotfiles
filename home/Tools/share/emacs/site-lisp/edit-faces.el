;;; edit-faces.el -- interactive face editing mode
(provide 'edit-faces)
;; Hacks by gilbertd@cs.man.ac.uk 7/95 to allow saveing of fonts - just
;; look under the menu in the edit fonts stuff.
;; it saves it in ~/emacs-faces.el - just put a 
;; (require 'edit-faces) 
;; and a
;; (load-file "~/.emacs-faces.el")
;; in your .emacs

;; Copyright (C) 1994, 1995 Tinker Systems and INS Engineering Corp.
;; 
;; This file is part of XEmacs.
;; 
;; XEmacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;; 
;; XEmacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with XEmacs; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

(or (fboundp 'insert-face)
    (defun insert-face (string face)
      "Insert STRING and highlight with FACE.  Returns the extent created."
      (let ((p (point)) ext)
	(insert string)
	(setq ext (make-extent p (point)))
	(set-extent-face ext face)
	ext)))

(defvar edit-faces-map
  (let ((map (make-sparse-keymap)))
    (suppress-keymap map)
    (define-key map "<" 'ef-smaller)
    (define-key map ">" 'ef-larger)
    (define-key map "c" 'ef-copy-other-face)
    (define-key map "C" 'ef-copy-this-face)
    (define-key map "s" 'ef-smaller)
    (define-key map "l" 'ef-larger)
    (define-key map "b" 'ef-bold)
    (define-key map "i" 'ef-italic)
    (define-key map "e" 'ef-font)
    (define-key map "f" 'ef-font)
    (define-key map "u" 'ef-underline)
    (define-key map "t" 'ef-truefont)
    (define-key map "F" 'ef-foreground)
    (define-key map "B" 'ef-background)
    (define-key map "d" 'ef-delete)
    (define-key map "n" 'ef-next)
    (define-key map "p" 'ef-prev)
    (define-key map " " 'ef-next)
    (define-key map "\C-?" 'ef-prev)
    (define-key map "g" 'edit-faces)	; refresh display
    (define-key map "q" 'ef-quit)
    (define-key map "\C-c\C-c" 'bury-buffer)
    map    
    ))

(defvar edit-faces-menu
  '("Edit-Faces"
    ["Copy other face..." ef-copy-other-face t]
    ["Copy this face..." ef-copy-this-face t]
    ["Make smaller"	ef-smaller	t]
    ["Make larger"	ef-larger	t]
    ["Toggle bold"	ef-bold		t]
    ["Toggle italic"	ef-italic	t]
    ["Toggle underline"	ef-underline	t]
    ["Query true font"	ef-truefont	t]
    ["Set font"		ef-font		t]
    ["Set foreground"	ef-foreground	t]
    ["Set background"	ef-background	t]
    ["Save faces"	save-faces     	t] ; hacked by DAG
    ["Quit"		ef-quit		t]
    ))

(or (find-face 'underline)
    (progn (make-face 'underline)
	   (set-face-underline-p 'underline t)))

;;;###autoload
(defun edit-faces ()
  "Alter face characteristics by editing a list of defined faces.
Pops up a buffer containing a list of defined faces.

Editing commands:

\\{edit-faces-map}"
  (interactive)

  (pop-to-buffer (get-buffer-create "*Edit Faces*"))
  (setq buffer-read-only nil
	major-mode 'edit-faces
	mode-name  "Edit-Faces"
	mode-popup-menu edit-faces-menu)
  (set (make-local-variable 'current-menubar)
       (copy-sequence current-menubar))
  (add-submenu nil edit-faces-menu)
  (erase-buffer)

  ;; face-list returns faces in a random order so we sort
  ;; alphabetically by the name in order to insert some logic into
  ;; the ordering.
  (let ((flist (sort (face-list)
		     (function
		      (lambda (x y)
			(string-lessp (symbol-name x) (symbol-name y))))))
	face)
    (ef-update-face-description t)	; insert header line
    (while (setq face (car flist))
      (ef-update-face-description face)
      (setq flist (cdr flist))
      ))
  (goto-char (point-min)) 
  (setq buffer-read-only t)
  (use-local-map edit-faces-map))

; gilbertd@cs.man.ac.uk
(defun save-faces ()
  "Inserts the elisp description of all known faces in the buffer (god knows which one....)"
  (interactive)
  (save-excursion
    (let ((oldbuf (current-buffer)))
      (set-buffer (create-file-buffer "~/.emacs-faces.el"))

      (set-visited-file-name "~/.emacs-faces.el")
 
      (let ((flist (face-list))
            face)

        (while (setq face (car flist))
           (ef-reloadable-face-description face)
           (setq flist (cdr flist))
        ) ; while on faces
      ) ; let flist

      (save-buffer)

      ;(set-buffer oldbuf)
      (kill-buffer (current-buffer))
    ) ; let oldbuf
  ) ; save-excursion
)

(defun ef-update-face-description (face &optional replace)
  "Given a face, inserts a description of that face into the current buffer.
Inserts a descriptive header if passed `t'."
  (let ((fmt "%-25s %-15s %-15s\n    %s\n")

	(buffer-read-only nil)
	fg bg font ex)
    (if (eq face t)
	(insert-face (format fmt "Face" "Foreground" "Background" "Font Spec")
		    'underline)
      (or replace (setq replace face))
      (goto-char (point-min)) 
      (if (re-search-forward (concat "^" (symbol-name replace) " ") nil 0)
	  (progn
	    (beginning-of-line)
	    (delete-region (point) (progn (forward-line 2) (point)))
	    ))
      (setq fg (face-foreground-instance face)
	    bg (face-background-instance face)
	    font (face-font-instance face)
	    ex (insert-face (format fmt
				   (symbol-name face)
				   (and fg (color-instance-name fg))
				   (and bg (color-instance-name bg))
				   (and font (font-instance-name font)))
			   face))
      (set-extent-property ex 'eface t)
      (set-extent-property ex 'start-open t)
      (and replace (forward-line -1))
      ))
  )

; hacked from above by gilbertd@cs.man.ac.uk
(defun ef-reloadable-face-description (face)
  "Given a face, inserts a lisp description of that face into the current buffer.
Inserts a descriptive header if passed `t'."
  (let ((fmt "(make-face '%1$s)\n\
              (set-face-foreground '%1$s \"%2$s\")\n\
              (set-face-background '%1$s \"%3$s\")\n\
              (set-face-font '%1$s \"%4$s\")\n")
	(buffer-read-only nil)
	fg bg font ex) 
     
      (setq fg (face-foreground-instance face)
	    bg (face-background-instance face)
	    font (face-font-instance face)
	    ex (insert (format fmt
				   (symbol-name face)
				   (and fg (color-instance-name fg))
				   (and bg (color-instance-name bg))
				   (and font (font-instance-name font))
                                   () () () () ())
			   ))
     )
  )

(defun ef-face-arg ()
   (and current-mouse-event
	(mouse-set-point current-mouse-event))
   (let ((ex (extent-at (1+ (point)) nil 'eface))) ; 1+ is a hack to deal
						   ; with start-open
     (or ex (error "There is no face to edit on this line."))
     (extent-face ex)))

(defun ef-delete (arg)
  "Delete the face on the current line from the *Edit Faces* buffer.
The face is not altered.  The buffer can be regenerated again with
M-x edit-faces."
  (interactive "p") 
  (and current-mouse-event
       (mouse-set-point current-mouse-event))
  (let ( ;; is this worth the bother? (fwd (> arg 0))
	(count (abs arg))
	(buffer-read-only nil)
	ex)
    (while (not (zerop (prog1 count (setq count (1- count)))))
      ;; 1+ is a hack to deal with start-open
      (setq ex (extent-at (1+ (point)) nil 'eface)) 
      (or ex (error "There is no face to delete on this line."))
      (delete-region (extent-start-position ex) (extent-end-position ex))
      (delete-blank-lines))))
  
(defun ef-next (arg)
  "Move forward ARG entries in the face table"
  (interactive "p") 
  (let ((fwd (> arg 0))
	(count (abs arg))
	ex)
    (while (not (zerop (prog1 count (setq count (1- count)))))
      ;; #### - 1+ is a hack to deal with start-open extents.  If they're not
      ;; start-open, then inserting text at the start of an extent will
      ;; cause the extent to grow, which is not desirable. 
      (setq ex (extent-at (1+ (point)) nil 'eface)) 
      (and ex
	   (if fwd
	       (progn (goto-char (extent-end-position ex))
		      (beginning-of-line 2))
	     (goto-char (extent-start-position ex))
	     (beginning-of-line -1)))	; ain't bug-compatibility great?
      )))

(defun ef-prev (arg)
  "Move forward ARG entries in the face table"
  (interactive "p") 
  (ef-next (- arg)))

(defun ef-smaller (face)
  (interactive (list (ef-face-arg)))
  (make-face-smaller face)
  (ef-update-face-description face))

(defun ef-larger (face)
  (interactive (list (ef-face-arg)))
  (make-face-larger face)
  (ef-update-face-description face))

(defun ef-face-font-indirect (face)
  (let ((font (face-font-instance face)))
    (or font (face-font-instance 'default))))

(defun ef-face-bold-p (face)
  (let ((font (ef-face-font-indirect face)))
    (not (not (string-match "-bold-" (font-instance-name font))))))

(defun ef-face-italic-p (face)
  (let ((font (ef-face-font-indirect face)))
    (not (not (string-match "-[io]-" (font-instance-name font))))))

(defun ef-bold (face)
  (interactive (list (ef-face-arg)))
  (if (ef-face-bold-p face)
      (make-face-unbold face)
    (make-face-bold face))
  (ef-update-face-description face))

(defun ef-italic (face)
  (interactive (list (ef-face-arg)))
  (if (ef-face-italic-p face)
      (make-face-unitalic face)
    (make-face-italic face))
  (ef-update-face-description face))

(defun ef-underline (face)
  (interactive (list (ef-face-arg)))
  (set-face-underline-p face (not (face-underline-p face)))
  (ef-update-face-description face))

(defun ef-truefont (face)
  (interactive (list (ef-face-arg)))
  (let ((font (face-font-instance face))
	(name (symbol-name face)))
    (if font
	(message "True font for `%s': %s" name (font-instance-truename font))
      (message "The face `%s' does not have its own font." name))))

(defun ef-foreground (face color)
  (interactive
   (let* ((f (ef-face-arg))
	  (name (symbol-name f))
	  (c (read-color (message "Foreground color for `%s': " name))))
     (list f c)))
  (set-face-foreground face color)
  (ef-update-face-description face))

(defun ef-background (face color)
  (interactive
   (let* ((f (ef-face-arg))
	  (name (symbol-name f))
	  (c (read-color (message "Background color for `%s': " name))))
     (list f c)))
  (set-face-background face color)
  (ef-update-face-description face))

(defun ef-copy-other-face (src dst)
  (interactive
   (let* ((f (ef-face-arg))
	  (name (symbol-name f)))
     (list (read-face (message "Make `%s' a copy of what face?: " name) t) f)))
  (copy-face src dst)
  (ef-update-face-description dst dst))

(defun ef-copy-this-face (src dst)
  (interactive
   (let* ((f (ef-face-arg))
	  (name (symbol-name f)))
       (list f (read-face (message "Copy `%s' onto what face?: " name)))))
  (copy-face src dst)
  (ef-update-face-description dst dst))

(defun ef-font (face font)
  (interactive
   (let* ((f (ef-face-arg))
	  (name (symbol-name f))
	  (font (face-font-instance f))
	  (nf (read-string (message "Font for `%s': " name)
			   (and font (font-instance-name font)))))
     (list f nf)))
  (let ((ofont (face-font-instance face))
	others)
    ;; you might think that this could be moved into the loop below, but I
    ;; think that it's important to see the new font before asking if the
    ;; change should be global. 
    (set-face-font face (if (and (string= font "")
				 (not (eq face 'default)))
			    nil font))
    (ef-update-face-description face)
    (setq others (delq nil (mapcar (lambda (f)
				     (and (equal (face-font-instance f) ofont)
					  f))
			       (face-list))))
    (if (and others
	     (y-or-n-p "Make the same font change for other faces? "))
	(while others
	  (setq face (car others)
		others (cdr others))
	  (set-face-font face font)
	  (ef-update-face-description face)))
    ))

(defun ef-quit ()
  (interactive)
  (or (one-window-p t 0)
      (delete-window))
  (kill-buffer "*Edit Faces*"))



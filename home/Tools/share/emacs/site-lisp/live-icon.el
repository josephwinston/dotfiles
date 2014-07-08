; $Id: //depot/Jody/main/jody/Tools/share/emacs/site-lisp/live-icon.el#1 $

; In comp.emacs.xemacs Rich Williams <rdw@hplb.hpl.hp.com> wrote:
; >
; > Anyway, Jamie has hacked around with it a bit, and the current
; > implementation stands thus :-

; I really love this.  Someone should have done this ages ago. :-)

; Anyway, my window manager restricts icons to 64x64, so I really want this
; thing to come up with icons that fit in that space (yet are still roughly the
; right aspect ratio.)  I started playing around with this (check the uncalled
; code at the end.)  It still doesn't quite work yet (let me say that again -
; this code is broken, so don't go reporting no bugs to me :-)) In fact, it
; might only work if you give it a target size of 40x40.  And it's really slow
; because it GCs a lot (and I didn't expect it to be consing at all, except for
; the strings) but here it is, in case someone besides Rich and I decides to
; get enthusiastic about this.  I won't have time to play with this again for
; a while.

; The basic idea was to iterate from dest->source instead of source->dest,
; and introduce scaling that way.

;	-- Jamie

; --------- slice 'n' dice --------------------------------- file: live-icon.el
;; frame-to-pixmap.el
;;
;; Generates little pixmaps representing the contents of your
;; frames.
;;
;; Written by Rich Williams <rdw@hplb.hpl.hp.com> 5th May 1995 
;; 
;; From an idea suggested by Jamie Zawinski <jwz@netscape.com>
;; posted to comp.emacs.xemacs on 2nd May 1995.
;;
;; This has been tested on (and will probably only work on)
;; Xemacs 19.12 beta 31. It should work on 19.11 but it'll 
;; need modification regarding face / colour calls.
;;
;; hacked by jwz
;; hacked by jsh 6/30/95 - removed all references to deprecated functions

(defun live-icon-colour-name-from-face (face &optional bg-p)
  "Do backward compatible things to faces and colours"
;; FIXME - rather than disabling the locale code, fix it! - jsh
  (if (not (and (boundp 'emacs-major-version)
		(= emacs-major-version 19)
		(= emacs-minor-version 12)))
      (let ((colour (if bg-p
			(face-background face 'all)
		      (face-foreground face 'all))))
	(if (consp colour)
	    (setq colour (cdr (car colour))))
	(if (color-instance-p colour)
	    (setq colour (color-instance-name colour)))
	(if (specifierp colour)
	    (setq colour (color-name colour)))
	(if colour
	    (let ((hack (format "%s" colour)))
	      (if (string-match "(?\\([^)]*)?\\)" hack)
		  (substring hack (match-beginning 1) (match-end 1))
		hack))))
    (let ((p (if bg-p (face-background face) (face-foreground face))))
      (and (color-specifier-p p)
	   (color-name p)))))

(defun live-icon-alloc-colour (cmv colour)
  "Allocate a colour and a char from the magic vector"
  (let ((bob (assoc colour (aref cmv 0)))
	(jim (aref cmv 2)))
    (if bob
	(cdr bob)
      (aset cmv 0 (cons (cons colour jim) (aref cmv 0)))
      (aset cmv 1 (1+ (aref cmv 1)))
      (aset cmv 2 (1+ jim))
      jim)))

(defun live-icon-from-frame (&optional frame)
  "Calculates the live-icon XPM of FRAME."
  (if (not frame)
      (setq frame (selected-frame)))
  (save-excursion
    (select-frame frame)
    (let* ((w (frame-width))
	   (h (frame-height))
	   (pix (make-vector h nil))
	   (ny 0)
	   (cmv (vector nil 0 ?A))
	   (d (live-icon-alloc-colour
	       cmv (color-name (face-background 'default))))
	   (m (live-icon-alloc-colour
	       cmv (color-name (face-background 'modeline))))
	   (x (live-icon-alloc-colour
	       cmv (color-name (face-foreground 'default))))
	   y)
      (let ((loop 0))
	(while (< loop h)
	  (aset pix loop (make-string w d))
	  (setq loop (1+ loop))))
      (mapcar #'(lambda (win)
		      (save-excursion
			(save-window-excursion
			  (select-window win)
			  (save-restriction
			    (setq y ny
				  ny (+ ny (1- (window-height))))
			    (aset pix (- ny 2) (make-string w m))
			    (widen)
			    (if (> (window-end) (window-start))
				(narrow-to-region (window-start)
						  (1- (window-end))))
			    (goto-char (point-min))
			    (while (and (not (eobp))
					(< y (1- ny)))
			      (while (and (not (eolp))
					  (< (current-column) w))
				(if (> (char-after (point)) 32)
				    (let* ((ex (extent-at (point) (current-buffer) 'face))
					   (f (if ex (extent-face ex)))
					   (z (if f (live-icon-colour-name-from-face f)))
					   (c (if z (live-icon-alloc-colour cmv z) x)))
				      (aset (aref pix y) (current-column) c)))
				(forward-char 1))
			      (setq y (1+ y))
			      (forward-line 1))))))
	      (sort (if (fboundp 'window-list)
			(window-list)
		      (let* ((w (frame-root-window))
			     (ws nil))
			(while (not (memq (setq w (next-window w)) ws))
			  (setq ws (cons w ws)))
			ws))
		    #'(lambda (won woo)
			(< (nth 1 (window-pixel-edges won))
			   (nth 1 (window-pixel-edges woo))))))
      (concat "/* XPM */\nstatic char icon[] = {\n" 
	      (format "\"%d %d %d 1\",\n" w (* h 2) (aref cmv 1))
	      (mapconcat #'(lambda (colour-entry)
			   (format "\"%c c %s\"" 
				   (cdr colour-entry) 
				   (car colour-entry)))
			 (aref cmv 0)
			 ",\n")
	      ",\n"
	      (mapconcat #'(lambda (scan-line)
			   (concat "\"" scan-line "\"," "\n"
;;				   "\"" scan-line "\""
				   "\"" (make-string w d) "\","
				   ))
			 pix
			 ",\n")
	      "};\n"))))


(defun live-icon-start-ppm-stuff (&optional frame)
  "Start a live icon conversion going"
  (interactive)
  (if (not frame)
      (setq frame (selected-frame)))
  (let ((buf (get-buffer-create " *live-icon*")))
    (message "live-icon...(backgrounding)")
    (save-excursion
      (set-buffer buf)
      (defvar live-icon-frame-variable)
      (make-local-variable 'live-icon-frame-variable)
      (setq live-icon-frame-variable frame)
      (erase-buffer))
    (set-process-sentinel
     (start-process-shell-command "live-icon"
				  buf
				  "xwd"
				  "-id" (format "%s" (x-window-id frame)) "|"
				  "xwdtopnm" "|" 
				  "pnmscale" "-xysize" "64" "64" "|"
				  "ppmquant" "256" "|"
				  "ppmtoxpm")
     #'(lambda (p s)
	 (message "live-icon...(munching)")
	 (save-excursion
	   (set-buffer " *live-icon*")
	   (goto-char (point-min))
	   (search-forward "/* XPM */")
	   (x-set-frame-icon-pixmap live-icon-frame-variable 
				    (make-glyph
				     (buffer-substring
				      (match-beginning 0) (point-max)))))
	 (message "live-icon...... done"))))
  nil)


(defun live-icon-one-frame (&optional frame)
  "Gives FRAME (defaulting to (selected-frame)) a live icon."
  (interactive)
;  (message "Updating live icon...")
  (if (not frame)
      (setq frame (selected-frame)))
  (x-set-frame-icon-pixmap frame (make-glyph (live-icon-from-frame frame)))
;  (message "Updating live icon... done")
  )

(defun live-icon-all-frames ()
  "Gives all your frames live-icons."
  (interactive)
  (message "Updating live icons...")
  (mapcar #'(lambda (fr)
	      (x-set-frame-icon-pixmap
	       fr (make-glyph (live-icon-from-frame fr))))
	  (frame-list))
  (message "Updating live icons... done"))

(add-hook 'unmap-frame-hook 'live-icon-one-frame)
;;(start-itimer "live-icon" 'live-icon-all-frames 120 120)



(defun live-icon-goto-position (x y)
  (let (window edges)
    (catch 'done
      (walk-windows
       #'(lambda (w)
	   (setq edges (window-pixel-edges w))
	   (if (and (>= x (nth 0 edges))
		    (<= x (nth 2 edges))
		    (>= y (nth 1 edges))
		    (<= y (nth 3 edges)))
	       (throw 'done (setq window w))))
       nil t))
    (if (not window)
	nil
      (select-window window)
      (move-to-window-line (- y (nth 1 edges)))
      (move-to-column (- x (nth 0 edges)))
      )))

(defun live-icon-make-image (width height)
  (let* ((text-aspect 1.5)
	 (xscale (/ (/ (* (frame-width)  1.0) width) text-aspect))
	 (yscale (/ (* (frame-height) 1.0) height))
	 (x 0)
	 (y 0)
	 (cmv (vector nil 0 ?A))
	 (default-fg (live-icon-alloc-colour
		      cmv (color-name (face-foreground 'default))))
	 (default-bg (live-icon-alloc-colour
		      cmv (color-name (face-background 'default))))
	 (modeline-bg (live-icon-alloc-colour
		       cmv (color-name (face-background 'modeline))))
	 (lines (make-vector height nil)))
    ;;
    ;; Put in the text.
    ;;
    (save-excursion
      (save-window-excursion
	(while (< y height)
	  (aset lines y (make-string width default-bg))
	  (setq x 0)
	  (while (< x width)
	    (let ((sx (floor (* x xscale)))
		  (sy (floor (* y yscale))))
	      (live-icon-goto-position sx sy)
	      (let* ((extent (extent-at (point) (current-buffer) 'face))
		     (face (if extent (extent-face extent)))
		     (name (if face (live-icon-colour-name-from-face
				     face (<= (char-after (point)) 32))))
		     (color (if name
				(live-icon-alloc-colour cmv name)
			      (if (<= (or (char-after (point)) 0) 32)
				  default-bg default-fg))))
		(aset (aref lines y) x color)))
	    (setq x (1+ x)))
	  (setq y (1+ y)))))
    ;;
    ;; Now put in the modelines.
    ;;
    (let (sx sy)
      (walk-windows
       #'(lambda (w)
	   (let ((edges (window-pixel-edges w)))
	     (setq x (nth 0 edges)
		   y (nth 3 edges)
		   sx (floor (/ x xscale))
		   sy (floor (/ y yscale)))
	     (while (and (< x (1- (nth 2 edges)))
			 (< sx (length (aref lines 0))))
	       (aset (aref lines sy) sx modeline-bg)
	       (if (> sy 0)
		   (aset (aref lines (1- sy)) sx modeline-bg))
	       (setq x (1+ x)
		     sx (floor (/ x xscale))))
	     (if (>= sx (length (aref lines 0)))
		 (setq sx (1- sx)))
	     (while (>= y (nth 1 edges))
	       (aset (aref lines sy) sx modeline-bg)
	       (setq y (1- y)
		     sy (floor (/ y yscale))))))
       nil nil))
    ;;
    ;; Now put in the top and left edges
    ;;
    (setq x 0)
    (while (< x width)
      (aset (aref lines 0) x modeline-bg)
      (setq x (1+ x)))
    (setq y 0)
    (while (< y height)
      (aset (aref lines y) 0 modeline-bg)
      (setq y (1+ y)))
    ;;
    ;; Now make the XPM
    ;;
    (concat "/* XPM */\nstatic char icon[] = {\n" 
	    (format "\"%d %d %d 1\",\n"
		    width
;;		    (* height 2)
		    height
		    (aref cmv 1))
	    (mapconcat #'(lambda (colour-entry)
			   (format "\"%c c %s\""
				   (cdr colour-entry) 
				   (car colour-entry)))
		       (aref cmv 0)
		       ",\n")
	    ",\n"
	    (mapconcat #'(lambda (scan-line)
			   (concat "\"" scan-line "\"," "\n"
;;				   "\"" scan-line "\""
;;				   "\"" (make-string width default-bg)
;;				   "\","
				   ))
		       lines
		       ",\n")
	    "};\n")))

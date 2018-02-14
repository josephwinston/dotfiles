;; -*- Emacs-Lisp -*-

;;
;; $Id: .calendar.el,v 1.2 2001/09/18 22:16:52 CVS_jody Exp $
;;

;;
;; diary and calendar
;;

;; Where are my diary entries?

(setq diary-file (concat home-directory "/.diary.el"))

;; (autoload 'appt-make-list "appt" nil t)
;; (add-hook 'diary-hook 'appt-make-list)

;; My sexps
(defun calendar-day-equal (date1 date2)
  "Returns t if the DATE1 and DATE2 are the same. (Does not check month)"
  (and
   (= (extract-calendar-day date1) (extract-calendar-day date2))
   (= (extract-calendar-year date1) (extract-calendar-year date2))))

(defun diary-any-month-float (dayname n)
  "Floating diary entry--entry applies if date is the nth dayname of any month."
  (if (calendar-day-equal
       date (calendar-nth-named-day
	     n dayname (extract-calendar-month date)
	     (extract-calendar-year date)))
      entry))

;; What to mark

(setq mark-holidays-in-calendar t)
(setq mark-diary-entries-in-calendar t)

;; do we have any messages today

(setq view-diary-entries-initially t)
(setq view-calendar-holidays-initially t)

;; What days to show in diary
;; Show the next 7 days every day
;; Not working in emacs 25

(setq number-of-diary-entries [7 7 7 7 7 7 7])

;; What holidays

(setq mark-holidays-in-calendar t)
;; (setq all-hebrew-calendar-holidays nil)
(setq all-islamic-calendar-holidays nil)
(setq all-christian-calendar-holidays t)

(setq diary-list-include-blanks t)

;; Timezones

;;
;; Some "random" default
;;

(setq calendar-location-name "Houston, TX")
(if (fboundp 'atan) (setq calendar-latitude 29.572084))
(if (fboundp 'atan) (setq calendar-longitude -95.130292))

(load (concat home-directory "/.$FULLNAME/$DOMAIN/.calendar.el") t)

;; Hooks

;; (setq nongregorian-diary-marking-hook 'mark-hebrew-diary-entries)
(setq mark-diary-entries-hook 'mark-included-diary-files)
;; (setq nongregorian-diary-listing-hook 'list-hebrew-diary-entries)
(setq list-diary-entries-hook
      '(include-other-diary-files
        (lambda nil
          (setq diary-entries-list
                (sort diary-entries-list 'diary-entry-compare)))))

(setq diary-display-hook 'fancy-diary-display)
      
(diary)
















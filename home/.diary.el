
;; -*- Emacs-Lisp -*-

;;
;; $Id: .diary.el,v 1.2 2002/12/16 15:38:10 CVS_jody Exp $
;;

%%(diary-sunrise-sunset)

(if (or (running-emacs19) 
	(running-emacs20) 
	(running-emacs21) 
	(running-emacs22) 
	(running-emacs23)
	(running-emacs24)
	(running-emacs25)
	)
    (%%(diary-phases-of-moon))

(if running-emacs25
    (%%(diary-lunar-phases))
  
%%(diary-day-of-year)

;; #include "texas"

;;
;; Houston Sun User's Group is the second Tuesday of every month
;;

;; &%%(diary-any-month-float 2 2) Hugs

;; Important Dates

&%%(diary-anniversary 5 29 1982) %d%s Wedding Anniversary

4/21 San Jac Holiday

;; Birthdays

&%%(diary-anniversary 03 07 1985) Joseph's %d%s Birthday
&%%(diary-anniversary 05 05 1960) Jody's %d%s Birthday
&%%(diary-anniversary 07 11 1983) Adrienne's %d%s Birthday
&%%(diary-anniversary 08 10 1991) Matthew's %d%s Birthday
&%%(diary-anniversary 09 07 1987) Nathaniel's %d%s Birthday
&%%(diary-anniversary 09 09 1999) Peter's %d%s Birthday
&%%(diary-anniversary 09 21 1995) Luke's %d%s Birthday
&%%(diary-anniversary 12 01 1993) Andrew's %d%s Birthday
&%%(diary-anniversary 12 18 1997) Philipp's %d%s Birthday
&%%(diary-anniversary 12 19 1961) Martha's %d%s Birthday
&%%(diary-anniversary 12 21 1989) Timothy's %d%s Birthday

2/21 Mary Ann ManCillas's Birthday
&%%(diary-anniversary 5 10 2002) Mary Ann ManCillas's %d%s Death
2/21 Neal Immega's Birthday
&%%(diary-anniversary 4 2 2005) Scott's %d%s Death at 12:30 CST

;;; Grandchildren

&%%(diary-anniversary 1 14 2015) Seren Winston %d%s Birthday
&%%(diary-anniversary 8 17 2017) Auroa Kalan Winston %d%s Birthday
&%%(diary-anniversary 1 14 2019) Brienne Danielle Winston %d%s Birthday

&%%(diary-anniversary 4 22 2019) Isabel Mariana Winston %d%s Birthday

;;; Parents

&%%(diary-anniversary 5 21 1938) Joe Winston, Jr. %d%s Birthday

;; HAL's Movie birthday

&%%(diary-anniversary 01 12 1992) HAL's %d%s Birthday

;; HAL's Book birthday

&%%(diary-anniversary 01 12 1997) HAL's %d%s Birthday

;; Holidays

;; Doctor

;; School

;; Vacation

;; Be Safe

;; Demos

;; Classes

;; Books

;; Training

2/17/04 St. John Lutheran, Seattle, WA 3:00 - 4:00 pm 
2/18/04 Prairie Luthern Church, Glasgow, MT 12:30 - 1:00 
2/19/04 Christ Lutheran Church, Marine on St. Croix, MN 11:30 - 12:00
2/23/04 Lutheran Student Center, Lincoln, NE 3:00 - 4:00 
3/1/04 Lord of Life Lutheran, Oswego, IL Pastor Woods 1:30 - 2:30 

;; Meetings

;; SGI is on the last Tuesday of the month

;; &%%(diary-any-month-float 2 -1) SGI

;; Usenix

;; &%%(diary-any-month-float 2 3) Houston Usenix 6:30 pm at HESS (Buffalo Speedway at Richmond)

;; Trips

;; To Do


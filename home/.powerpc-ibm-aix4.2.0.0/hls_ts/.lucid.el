;; -*- Emacs-Lisp -*-

;;
;; $Id: //depot/Jody/main/jody/.powerpc-ibm-aix4.2.0.0/hls_ts/.lucid.el#1 $
;;

;;
;; Warning this does not let you use ange-ftp
;;

;;
;; ff-paths
;;

(require 'dired)
(require 'ff-paths)

(define-key ctl-x-map "\C-f" 'find-file-using-paths)
(setq ff-paths-prompt nil)

(setq ff-paths-list
      '(
	;; 3dApp
	("bcd[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/bcd")
	("bmt[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/bmt")
	("bsc[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/bsc")
	("bsf[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/bsf")
	("bsg[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/bsg")
	("imt[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/imt")
	("ine[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/ine")
	("inf[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/inf")
	("inm[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/inm")
	("inn[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/inn")
	("inv[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/inv")
	("xhc[a-zA-Z0-9]*\.C$" "~/gm/src/lib/3dApp/xhc")

	("bcd[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/bcd")
	("bmt[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/bmt")
	("bsc[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/bsc")
	("bsf[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/bsf")
	("bsg[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/bsg")
	("imt[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/imt")
	("ine[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/ine")
	("inf[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/inf")
	("inm[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/inm")
	("inn[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/inn")
	("inv[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/inv")
	("xhc[a-zA-Z0-9]*\.h$" "~/gm/src/include/3dApp/xhc")

	;; EarthCube
	("ecd[a-zA-Z0-9]*\.C$" "~/gm/src/lib/EarthCube/ecd")
	("ecf[a-zA-Z0-9]*\.C$" "~/gm/src/lib/EarthCube/ecf")
	("ecp[a-zA-Z0-9]*\.C$" "~/gm/src/lib/EarthCube/ecp")
	("efi[a-zA-Z0-9]*\.C$" "~/gm/src/lib/EarthCube/efi")
	("eft[a-zA-Z0-9]*\.C$" "~/gm/src/lib/EarthCube/eft")
	("ehz[a-zA-Z0-9]*\.C$" "~/gm/src/lib/EarthCube/ehz")
	("emt[a-zA-Z0-9]*\.C$" "~/gm/src/lib/EarthCube/emt")
	("esi[a-zA-Z0-9]*\.C$" "~/gm/src/lib/EarthCube/esi")
	("esr[a-zA-Z0-9]*\.C$" "~/gm/src/lib/EarthCube/esr")

	("ecd[a-zA-Z0-9]*\.h$" "~/gm/src/include/EarthCube/ecd")
	("ecf[a-zA-Z0-9]*\.h$" "~/gm/src/include/EarthCube/ecf")
	("ecp[a-zA-Z0-9]*\.h$" "~/gm/src/include/EarthCube/ecp")
	("efi[a-zA-Z0-9]*\.h$" "~/gm/src/include/EarthCube/efi")
	("eft[a-zA-Z0-9]*\.h$" "~/gm/src/include/EarthCube/eft")
	("ehz[a-zA-Z0-9]*\.h$" "~/gm/src/include/EarthCube/ehz")
	("emt[a-zA-Z0-9]*\.h$" "~/gm/src/include/EarthCube/emt")
	("esi[a-zA-Z0-9]*\.h$" "~/gm/src/include/EarthCube/esi")
	("esr[a-zA-Z0-9]*\.h$" "~/gm/src/include/EarthCube/esr")

))


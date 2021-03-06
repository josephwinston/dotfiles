;;
;;
;;

(autoload 'gtags-mode "gtags" "" t)

;;
;; cedet
;;

(load-file "~/Tools/share/cedet/common/cedet.el")
(global-ede-mode t)                      ; Enable the Project management system

;;
;; (select only one)
;;
;; (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
;; (semantic-load-enable-gaudy-code-helpers)
(semantic-load-enable-excessive-code-helpers)

(require 'semantic-ia)
(require 'semantic-gcc)
(require 'semanticdb)
(global-semanticdb-minor-mode 1)

(require 'semanticdb-global)

;;
;; Turn off some decoration
;;

(semantic-toggle-decoration-style "semantic-tag-boundary" -1)
(semantic-toggle-decoration-style "semantic-decoration-on-private-members" -1)
(semantic-toggle-decoration-style "semantic-decoration-on-protected-members" -1)

;;
;; Set up idle processing
;;

(global-semantic-idle-scheduler-mode 1) ; The idle scheduler with automatically reparse buffers in idle time.
(global-semantic-idle-completions-mode 1) ; Display a tooltip with a list of possible completions near the cursor.
(global-semantic-idle-summary-mode 1) ; Display a tag summary of the lexical token under the cursor.

;;
;; Define the location of tools
;;

(setq cedet-graphviz-dot-command "C:/Program Files (x86)/Graphviz2.27/bin/dot.exe")
(setq cedet-graphviz-neato-command "C:/Program Files (x86)/Graphviz2.27/bin/neato.exe")

;;
;; Common includes
;;

(semantic-add-system-include "C:/Program Files (x86)/Microsoft Visual Studio 9.0/VC/include" 'c++-mode)

(semantic-add-system-include "~/work/Caprica/ExternalLibs/Boost-1.39.0/include/boost-1_39" 'c++-mode)
(semantic-add-system-include "~/work/Caprica/ExternalLibs/OpenSceneGraph-2.9.5/include" 'c++-mode)

;;
;; World slows down with so many includes (eg press a period)
;;

;; (semantic-add-system-include "~/work/Caprica/dependencies/owdevkit/include/include" 'c++-mode)
;; (semantic-add-system-include "~/work/Caprica/dependencies/carto/include/include" 'c++-mode)
;; (semantic-add-system-include "~/work/Caprica/dependencies/tddevkit/include" 'c++-mode)
;; (semantic-add-system-include "~/work/Caprica/dependencies/swdevkit/include" 'c++-mode)
;; (semantic-add-system-include "~/work/Caprica/dependencies/bluemarble/include" 'c++-mode)
;; (semantic-add-system-include "~/work/Caprica/dependencies/licensing/include" 'c++-mode)

(setq qt4-base-dir (expand-file-name "~/work/Caprica/ExternalLibs/Qt/git-head/Windows64/include"))
(semantic-add-system-include qt4-base-dir 'c++-mode)
(semantic-add-system-include (concat qt4-base-dir "/Qt") 'c++-mode)
(semantic-add-system-include (concat qt4-base-dir "/QtCore") 'c++-mode)
(semantic-add-system-include (concat qt4-base-dir "/QtOpenGL") 'c++-mode)
(semantic-add-system-include (concat qt4-base-dir "/QtGui") 'c++-mode)
(add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/QtCore/qconfig.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/QtCore/qconfig-dist.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/QtCore/qglobal.h"))

;;
;; Requires gnu's global
;;

(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
(global-semanticdb-minor-mode 1)

;;
;; Hooks
;;

(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;; enable ctags for some languages:
;; Not recommended for use with templated code
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; (semantic-load-enable-primary-exuberent-ctags-support)

(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(defun my-c-mode-cedet-hook ()
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert))
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(add-to-list 'load-path
	     "~/Tools/share/ecb")
(require 'ecb)

;;Turn off Tip of the day
(setq ecb-tip-of-the-day nil)

;; Set the layout
(setq ecb-layout-name "leftright-analyse")

;;
;; Projects
;;


(ede-cpp-root-project "Caprica"
                :name "Caprica Project"
                :file "~/work/Caprica/CMakeLists.txt"
                :include-path '("/Appls/ChunkView"
				"/Appls/ChunkView/Utils"
				"/Appls/ShmService"
				"/Utils"
				"/Utils/ThreadQueue"
				)
                :system-include-path '("C:/Program Files (x86)/Microsoft Visual Studio 9.0/VC/include"
				       )
                :spp-table '(("WIN32" . "")
			     ("WINDOWS" . "")
			     ("USING_QT" . "")
			     ("_CRT_SECURE_NO_DEPRECATE" . "")
			     ("_SCL_SECURE_NO_DEPRECATE" . "")
			     ("_CRT_SECURE_NO_WARNINGS" . "")
			     ("_SCL_SECURE_NO_WARNINGS" . "")
			     ("_WIN32_WINNT" . "0x0600")
                             ("LMK_SHM" . "")
			     ("HAVE_INVENTOR" . "")
			     ("OSG_STATIC_PLUGINS" . "")
			     ("BOOST_ALL_NO_LIB" . "")
			     )
		)



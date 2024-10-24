(module hub)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                  ;;;;
;;;;    X.Y HALTING   ;;;;
;;;;                  ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun    (halting-instruction---is-RETURN)          [ stack/DEC_FLAG  1 ])
(defun    (halting-instruction---is-REVERT)          [ stack/DEC_FLAG  2 ])
(defun    (halting-instruction---is-STOP)            [ stack/DEC_FLAG  3 ])
(defun    (halting-instruction---is-SELFDESTRUCT)    [ stack/DEC_FLAG  4 ])

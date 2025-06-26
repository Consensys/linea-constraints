(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                               ;;;;
;;;;    X.5 Instruction handling   ;;;;
;;;;                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    X.Y.Z MCOPY instruction   ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (mcopy-instruction---target-offset-hi) [ STACK_ITEM_VALUE_HI 1 ] )
(defun (mcopy-instruction---target-offset-lo) [ STACK_ITEM_VALUE_HI 1 ] )
(defun (mcopy-instruction---source-offset-hi) [ STACK_ITEM_VALUE_HI 2 ] )
(defun (mcopy-instruction---source-offset-lo) [ STACK_ITEM_VALUE_HI 2 ] )
(defun (mcopy-instruction---size-hi)          [ STACK_ITEM_VALUE_HI 3 ] )
(defun (mcopy-instruction---size-lo)          [ STACK_ITEM_VALUE_HI 3 ] ) ;; ""

(defun (mcopy-instruction---MXP-mxpx)       (shift misc/MXP_MXPX                   MCOPY_ROFF___1ST_MISC_ROW ))
(defun (mcopy-instruction---MXP-gas-mxp)    (shift misc/MXP_GAS_MXP                MCOPY_ROFF___1ST_MISC_ROW ))
(defun (mcopy-instruction---MXP-s1nznomxpx) (shift misc/MXP_SIZE_1_NONZERO_NO_MXPX MCOPY_ROFF___1ST_MISC_ROW ))

(defun (mcopy-instruction---standard-precondition)   (*   PEEK_AT_STACK
                                                          stack/MCOPY_FLAG
                                                          (-   1
                                                               stack/SUX
                                                               stack/SOX)))

(defconst
  MCOPY_ROFF___1ST_MISC_ROW  1
  MCOPY_ROFF___2ND_MISC_ROW  2
  MCOPY_ROFF___XCON_ROW  2
  )

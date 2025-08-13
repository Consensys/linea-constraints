(module txndata)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;    X.Y.Z NOOP transactions    ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun   (first-row-of-SYSI-NOOP-transaction)   (*   (first-row-of-SYSI-transaction)   (shift  hub/NOOP   ROFF___SYSI___HUB_ROW)))

(defconst
  ROFF_SYSI_NOOP___FIRST_AND_ONLY_COMPUTATION_ROW   1
  )


(defconstraint   (SYSI-NOOP---nothing-happens)
		 (:guard (first-row-of-SYSI-NOOP-transaction))
		 (vanishes!   (shift   (+   computation/WCP_FLAG   computation/EUC_FLAG)   ROFF_SYSI_NOOP___FIRST_AND_ONLY_COMPUTATION_ROW)))

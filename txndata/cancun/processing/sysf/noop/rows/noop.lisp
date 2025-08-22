(module txndata)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                      ;;
;;    X. SYSF transaction processing    ;;
;;    X.Y Generalities                  ;;
;;                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun    (first-row-of-SYSF-transaction)    (force-bin    (*   (- TOTL_TXN_NUMBER (prev TOTL_TXN_NUMBER))   SYSF)))


(defconstraint   SYSF-prelude-constraints---noop-transactions-require-no-computations
		 (:guard (first-row-of-SYSF-transaction))
		 (eq!    (+   (shift   computation/EUC_FLAG    ROFF___SYSF___CMP_ROW)
                              (shift   computation/WCP_FLAG    ROFF___SYSF___CMP_ROW))
                         0))


(module txndata)


(defcolumns
  ( prover___REL_USER_TXN_NUMBER         :i16 )
  ( prover___REL_USER_TXN_NUMBER_MAX     :i16 )
  ( prover___IS_LAST_USER_TXN_OF_BLOCK   :i16 )
  ( prover___USER_TXN_NUMBER_MAX         :i16 )
  )

(defalias
  prv_RUSR   prover___REL_USER_TXN_NUMBER
  prv_RMAX   prover___REL_USER_TXN_NUMBER_MAX
  prv_LAST   prover___IS_LAST_USER_TXN_OF_BLOCK
  prv_UMAX   prover___USER_TXN_NUMBER_MAX
  )

(defun
  (block-constancy   COL)
  (if-not-zero   (-   (next BLK_NUMBER)   BLK_NUMBER)
		 (eq! (next  COL)  COL)))

(defun
  (conflation-constancy   COL)
  (if-not-zero   (perspective-sum)
		 (eq!  (next  COL)  COL)))

(defun
  (transaction-constancy   COL)
  (if-not-zero   (-   (next TOTL_TXN_NUMBER)   TOTL_TXN_NUMBER)
		 (eq! (next  COL)  COL)))


(defconstraint    prover-column-constraints---RUSR ()
		  (begin
		    (block-constancy   prv_RUSR)
		    (if-zero  (perspective-sum)
			      (vanishes!   prv_RUSR))
		    (if-not-zero   (-  (next  BLK_NUMBER)  BLK_NUMBER)
				   (vanishes!   prv_RUSR))
		    (if-not-zero   (-  (next  BLK_NUMBER)  (+  BLK_NUMBER  1))
				   (eq!   (next  prv_RUSR)
					  (+   prv_RUSR
					       (-   (next   USER_TXN_NUMBER)
						    USER_TXN_NUMBER))))
		    ))

(defconstraint    prover-column-constraints---RMAX ()
		  (begin
		    (block-constancy   prv_RMAX)
		    (if-zero   (perspective-sum)
			       (vanishes!   prv_RMAX))
		    (if-not-zero   SYSF
				   (eq!   prv_RMAX   prv_RUSR))
		    ))

(defconstraint    prover-column-constraints---LAST ()
		  (begin
		    (transaction-constancy   prv_LAST)
		    (if-zero   USER
			       (vanishes!   prv_LAST))
		    (if-not-zero   (-  TOTL_TXN_NUMBER   (next  TOTL_TXN_NUMBER))
				   (eq!   (prev   prv_LAST)
					  (*   (prev   USER)
					       SYSF)))
		    ))

(defconstraint    prover-column-constraints---UMAX ()
		  (begin
		    (conflation-constancy   prv_UMAX)
		    (if-zero   (perspective-sum)
			       (vanishes!   prv_UMAX))
		    ))

(defconstraint    prover-column-constraints---UMAX---finalization (:domain {-1}) ;; ""
		  (eq!   prv_UMAX   USER_TXN_NUMBER))

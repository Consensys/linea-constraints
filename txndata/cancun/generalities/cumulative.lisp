(module txndata)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        ;;
;;    X.Y.Z GAS_CUMULATIVE constraints    ;;
;;                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint    GAS_CUMULATIVE-constraints---counter-constancy                          ()
		  (counter-constancy    GAS_CUMULATIVE    CT))

(defconstraint    GAS_CUMULATIVE-constraints---it-vanishes-outside-of-USER-and-SYSF-rows  ()
		  (if-zero   (force-bin   (+   USER   SYSF))
			     (vanishes!   GAS_CUMULATIVE)))

(defconstraint    GAS_CUMULATIVE-constraints---update-at-USER-transaction-boundaries      ()
		  (if-not-zero    (-   (next   USER_TXN_NUMBER)   USER_TXN_NUMBER)
				  (begin
				    (eq!   (next   HUB)   1) ;; sanity check in the spec
				    (will-inc!   GAS_CUMULATIVE
						 (next   (-   hub/GAS_LIMIT   hub/REFUND_EFFECTIVE))))))

(defconstraint    GAS_CUMULATIVE-constraints---it-remains-constant-during-FINL-rows       ()
		  (if-not-zero   SYSF
				 (remained-constant!   GAS_CUMULATIVE)))

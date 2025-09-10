(module txndata)


;; TODO: disable for Prague


(defconstraint    fork-specifics---cancun-specifics---SYSI-transactions ()
		  (if-not-zero    SYSI
				  (if-not-zero    HUB
						  (eq!    hub/EIP_4788    1))))

(defconstraint    fork-specifics---cancun-specifics---SYSF-transactions ()
		  (if-not-zero    SYSF
				  (if-not-zero    HUB
						  (eq!    hub/NOOP    1))))

(defconstraint    fork-specifics---cancun-specifics---transaction-order ()
		  (if-not-zero    (*   (prev (- 1 SYSI))  SYSI)
				  (begin
				    (eq!    HUB             1)
				    (eq!    hub/EIP_4788    1)
				    (eq!   (shift   (+ USER SYSF)   nROWS___EIP_4788)   1)
				    )))

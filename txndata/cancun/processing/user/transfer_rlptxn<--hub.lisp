(module txndata)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                      ;;
;;    X. USER transaction processing    ;;
;;    X.Y Data transfer RLP <-- HUB     ;;
;;                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint   USER-transaction---data-transfer---RLP<==HUB---passing-the-CFI-along
		 (:guard   (first-row-of-USER-transaction))
		 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		 (eq!   (shift   rlp/CFI   ROFF___USER___RLP_ROW)
			(shift   hub/CFI   ROFF___USER___HUB_ROW)
			))

(defconstraint   USER-transaction---data-transfer---RLP<==HUB---passing-the-REQUIRES_EVM_EXECUTION-bit-along
		 (:guard   (first-row-of-USER-transaction))
		 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


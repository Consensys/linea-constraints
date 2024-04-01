(defun (hub-into-rlp-txn-src-selector)  hub.TX_WARM)

(defun (hub-into-rlp-txn-tgt-selector)  (*   rlpTxn.REQUIRES_EVM_EXECUTION
                                             [ rlpTxn.PHASE 11 ] ))          ;; TODO: 11 should be replaced by sthg à la PHASE_RLP_ACCESS_SET

;;
(deflookup hub-into-rlp-txn
           ;; target columns
	   ( 
              (* rlpTxn.ABS_TX_NUM                      (hub-into-rlp-txn-tgt-selector))
              (hub-into-rlp-txn-tgt-selector)
              (* (rlp-txn-depth-2)                      (hub-into-rlp-txn-tgt-selector))
              (* (- 1 (rlp-txn-depth-2))                (hub-into-rlp-txn-tgt-selector))
              (* rlpTxn.ADDR_HI                         (hub-into-rlp-txn-tgt-selector))
              (* rlpTxn.ADDR_LO                         (hub-into-rlp-txn-tgt-selector))
              (* [ rlpTxn.INPUT 1 ]  (rlp-txn-depth-2)  (hub-into-rlp-txn-tgt-selector))
              (* [ rlpTxn.INPUT 2 ]  (rlp-txn-depth-2)  (hub-into-rlp-txn-tgt-selector))
           )
           ;; source columns
	   (
	     hub.ABSOLUTE_TRANSACTION_NUMBER
             hub.TX_WARM
	     hub.PEEK_AT_ACCOUNT
	     hub.PEEK_AT_STORAGE
	     (prewarming-phase-address-hi)
	     (prewarming-phase-address-lo)
	     (prewarming-phase-storage-key-hi)
	     (prewarming-phase-storage-key-lo)
           )
)

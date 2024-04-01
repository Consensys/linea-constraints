(defun (hub-into-rlp-txn-src-selector)
  hub.TX_WARM)

(defun (hub-into-rlp-txn-tgt-selector)
  (* (- 1 rlpTxn.IS_PREFIX) [rlpTxn.PHASE 11])) ;; TODO: 11 should be replaced by sthg à la PHASE_RLP_ACCESS_SET

;;
(deflookup 
  hub-into-rlp-txn
  ;; target columns
  (
    (* (hub-into-rlp-txn-tgt-selector) rlpTxn.REQUIRES_EVM_EXECUTION)
    rlpTxn.ABS_TX_NUM
    (* (rlp-txn-depth-2)       (hub-into-rlp-txn-tgt-selector)) ;; TODO: multiplication by selector likely unnecessary
    (* (- 1 (rlp-txn-depth-2)) (hub-into-rlp-txn-tgt-selector))
    rlpTxn.ADDR_HI
    rlpTxn.ADDR_LO
    (* [rlpTxn.INPUT 1] (rlp-txn-depth-2))
    (* [rlpTxn.INPUT 2] (rlp-txn-depth-2))
  )
  ;; source columns
  (
    (hub-into-rlp-txn-src-selector)
    (* hub.ABSOLUTE_TRANSACTION_NUMBER     (hub-into-rlp-txn-src-selector))
    (* hub.PEEK_AT_ACCOUNT                 (hub-into-rlp-txn-src-selector))
    (* hub.PEEK_AT_STORAGE                 (hub-into-rlp-txn-src-selector))
    (* (prewarming-phase-address-hi)       (hub-into-rlp-txn-src-selector))
    (* (prewarming-phase-address-lo)       (hub-into-rlp-txn-src-selector))
    (* (prewarming-phase-storage-key-hi)   (hub-into-rlp-txn-src-selector))
    (* (prewarming-phase-storage-key-lo)   (hub-into-rlp-txn-src-selector))
  ))

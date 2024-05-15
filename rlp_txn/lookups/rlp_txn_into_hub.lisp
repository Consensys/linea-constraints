(defun (rlp-txn-into-hub-src-selector) (* (- 1 rlptxn.IS_PREFIX)
                                          rlptxn.REQUIRES_EVM_EXECUTION
                                          [rlptxn.PHASE 11])) ;; TODO: 11 should be replaced by sthg à la PHASE_RLP_ACCESS_SET

(defun (prewarming-phase-address-hi)
  (+ (* hub.PEEK_AT_ACCOUNT hub.account/ADDRESS_HI) (* hub.PEEK_AT_STORAGE hub.storage/ADDRESS_HI)))

(defun (prewarming-phase-address-lo)
  (+ (* hub.PEEK_AT_ACCOUNT hub.account/ADDRESS_LO) (* hub.PEEK_AT_STORAGE hub.storage/ADDRESS_LO)))

(defun (prewarming-phase-storage-key-hi)
  (* hub.PEEK_AT_STORAGE hub.storage/STORAGE_KEY_HI))

(defun (prewarming-phase-storage-key-lo)
  (* hub.PEEK_AT_STORAGE hub.storage/STORAGE_KEY_LO))

(defun (rlp-txn-depth-2)
  [rlptxn.DEPTH 2])

(deflookup
  rlp-txn-into-hub
  ;; target columns
  (
    hub.TX_WARM
    hub.ABSOLUTE_TRANSACTION_NUMBER
    hub.PEEK_AT_ACCOUNT
    hub.PEEK_AT_STORAGE
    (prewarming-phase-address-hi)
    (prewarming-phase-address-lo)
    (prewarming-phase-storage-key-hi)
    (prewarming-phase-storage-key-lo)
  )
  ;; source columns
  (
    (rlp-txn-into-hub-src-selector)
    (* rlptxn.ABS_TX_NUM                      (rlp-txn-into-hub-src-selector))
    (* (rlp-txn-depth-2)                      (rlp-txn-into-hub-src-selector))
    (* (- 1 (rlp-txn-depth-2))                (rlp-txn-into-hub-src-selector))
    (* rlptxn.ADDR_HI                         (rlp-txn-into-hub-src-selector))
    (* rlptxn.ADDR_LO                         (rlp-txn-into-hub-src-selector))
    (* [rlptxn.INPUT 1] (rlp-txn-depth-2)     (rlp-txn-into-hub-src-selector))
    (* [rlptxn.INPUT 2] (rlp-txn-depth-2)     (rlp-txn-into-hub-src-selector))
  ))



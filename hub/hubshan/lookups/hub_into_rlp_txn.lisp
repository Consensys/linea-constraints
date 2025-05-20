(defun (hub-into-rlp-txn-src-selector) hubshan.TX_WARM)

;; DUPLICATE
(defun (rlp-txn-depth-2)
  [rlptxn.DEPTH 2]) ;; ""

;; DUPLICATES
(defun (prewarming-phase-address-hi)     (+ (* hubshan.PEEK_AT_ACCOUNT hubshan.account/ADDRESS_HI) (* hubshan.PEEK_AT_STORAGE hubshan.storage/ADDRESS_HI)))
(defun (prewarming-phase-address-lo)     (+ (* hubshan.PEEK_AT_ACCOUNT hubshan.account/ADDRESS_LO) (* hubshan.PEEK_AT_STORAGE hubshan.storage/ADDRESS_LO)))
(defun (prewarming-phase-storage-key-hi) (* hubshan.PEEK_AT_STORAGE hubshan.storage/STORAGE_KEY_HI))
(defun (prewarming-phase-storage-key-lo) (* hubshan.PEEK_AT_STORAGE hubshan.storage/STORAGE_KEY_LO))

(defun (hub-into-rlp-txn-tgt-selector)   (*   rlptxn.REQUIRES_EVM_EXECUTION
                                              rlptxn.IS_PHASE_ACCESS_LIST
                                              (- 1 rlptxn.IS_PREFIX)))

(deflookup
  hub-into-rlptxn
  ;; target columns
  ;; TODO: multiplication by selector likely unnecessary but as we multiply by the same column for the lookup tlptxn into hub ...
  (
    (* 1                                    (hub-into-rlp-txn-tgt-selector))
    (* rlptxn.ABS_TX_NUM                    (hub-into-rlp-txn-tgt-selector))
    (* (- 1 (rlp-txn-depth-2))              (hub-into-rlp-txn-tgt-selector))
    (* (rlp-txn-depth-2)                    (hub-into-rlp-txn-tgt-selector))

    (* rlptxn.ADDR_HI                       (hub-into-rlp-txn-tgt-selector))
    (* rlptxn.ADDR_LO                       (hub-into-rlp-txn-tgt-selector))
    (* [rlptxn.INPUT 1] (rlp-txn-depth-2)   (hub-into-rlp-txn-tgt-selector))
    (* [rlptxn.INPUT 2] (rlp-txn-depth-2)   (hub-into-rlp-txn-tgt-selector)) ;; ""
  )
  ;; source columns
  (
    (* 1                                    (hub-into-rlp-txn-src-selector))
    (* hubshan.ABSOLUTE_TRANSACTION_NUMBER      (hub-into-rlp-txn-src-selector))
    (* hubshan.PEEK_AT_ACCOUNT                  (hub-into-rlp-txn-src-selector))
    (* hubshan.PEEK_AT_STORAGE                  (hub-into-rlp-txn-src-selector))

    (* (prewarming-phase-address-hi)        (hub-into-rlp-txn-src-selector))
    (* (prewarming-phase-address-lo)        (hub-into-rlp-txn-src-selector))
    (* (prewarming-phase-storage-key-hi)    (hub-into-rlp-txn-src-selector))
    (* (prewarming-phase-storage-key-lo)    (hub-into-rlp-txn-src-selector))
  ))

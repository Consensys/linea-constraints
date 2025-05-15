(defun (hub-into-rlp-txn-src-selector-shan) hubshan.TX_WARM)

;; DUPLICATE
(defun (rlp-txn-depth-2-shan)
  [rlptxnshan.DEPTH 2]) ;; ""

;; DUPLICATES
(defun (prewarming-phase-address-hi-shan)     (+ (* hubshan.PEEK_AT_ACCOUNT hubshan.account/ADDRESS_HI) (* hubshan.PEEK_AT_STORAGE hubshan.storage/ADDRESS_HI)))
(defun (prewarming-phase-address-lo-shan)     (+ (* hubshan.PEEK_AT_ACCOUNT hubshan.account/ADDRESS_LO) (* hubshan.PEEK_AT_STORAGE hubshan.storage/ADDRESS_LO)))
(defun (prewarming-phase-storage-key-hi-shan) (* hubshan.PEEK_AT_STORAGE hubshan.storage/STORAGE_KEY_HI))
(defun (prewarming-phase-storage-key-lo-shan) (* hubshan.PEEK_AT_STORAGE hubshan.storage/STORAGE_KEY_LO))

(defun (hub-into-rlp-txn-tgt-selector-shan)   (*   rlptxnshan.REQUIRES_EVM_EXECUTION
                                              rlptxnshan.IS_PHASE_ACCESS_LIST
                                              (- 1 rlptxnshan.IS_PREFIX)))

(deflookup
  hub-into-rlptxn
  ;; target columns
  ;; TODO: multiplication by selector likely unnecessary but as we multiply by the same column for the lookup tlptxn into hub ...
  (
    (* 1                                    (hub-into-rlp-txn-tgt-selector-shan))
    (* rlptxnshan.ABS_TX_NUM                    (hub-into-rlp-txn-tgt-selector-shan))
    (* (- 1 (rlp-txn-depth-2-shan))              (hub-into-rlp-txn-tgt-selector-shan))
    (* (rlp-txn-depth-2-shan)                    (hub-into-rlp-txn-tgt-selector-shan))

    (* rlptxnshan.ADDR_HI                       (hub-into-rlp-txn-tgt-selector-shan))
    (* rlptxnshan.ADDR_LO                       (hub-into-rlp-txn-tgt-selector-shan))
    (* [rlptxnshan.INPUT 1] (rlp-txn-depth-2-shan)   (hub-into-rlp-txn-tgt-selector-shan))
    (* [rlptxnshan.INPUT 2] (rlp-txn-depth-2-shan)   (hub-into-rlp-txn-tgt-selector-shan)) ;; ""
  )
  ;; source columns
  (
    (* 1                                    (hub-into-rlp-txn-src-selector-shan))
    (* hubshan.ABSOLUTE_TRANSACTION_NUMBER      (hub-into-rlp-txn-src-selector-shan))
    (* hubshan.PEEK_AT_ACCOUNT                  (hub-into-rlp-txn-src-selector-shan))
    (* hubshan.PEEK_AT_STORAGE                  (hub-into-rlp-txn-src-selector-shan))

    (* (prewarming-phase-address-hi-shan)        (hub-into-rlp-txn-src-selector-shan))
    (* (prewarming-phase-address-lo-shan)        (hub-into-rlp-txn-src-selector-shan))
    (* (prewarming-phase-storage-key-hi-shan)    (hub-into-rlp-txn-src-selector-shan))
    (* (prewarming-phase-storage-key-lo-shan)    (hub-into-rlp-txn-src-selector-shan))
  ))

(defun (rlp-txn-into-hub-src-selector-shan) (* rlptxnshan.REQUIRES_EVM_EXECUTION rlptxnshan.IS_PHASE_ACCESS_LIST (- 1 rlptxnshan.IS_PREFIX)))

(deflookup 
  rlptxn-into-hub
  ;; target columns
  (
   hubshan.TX_WARM
   hubshan.ABSOLUTE_TRANSACTION_NUMBER
   hubshan.PEEK_AT_ACCOUNT
   hubshan.PEEK_AT_STORAGE
   (prewarming-phase-address-hi-shan)
   (prewarming-phase-address-lo-shan)
   (prewarming-phase-storage-key-hi-shan)
   (prewarming-phase-storage-key-lo-shan)
   )
  ;; source columns
  (
                                            (rlp-txn-into-hub-src-selector-shan)
   (* rlptxnshan.ABS_TX_NUM                     (rlp-txn-into-hub-src-selector-shan))
   (* (- 1 (rlp-txn-depth-2-shan))               (rlp-txn-into-hub-src-selector-shan))
   (* (rlp-txn-depth-2-shan)                     (rlp-txn-into-hub-src-selector-shan))
   (* rlptxnshan.ADDR_HI                        (rlp-txn-into-hub-src-selector-shan))
   (* rlptxnshan.ADDR_LO                        (rlp-txn-into-hub-src-selector-shan))
   (* [rlptxnshan.INPUT 1] (rlp-txn-depth-2-shan)    (rlp-txn-into-hub-src-selector-shan))
   (* [rlptxnshan.INPUT 2] (rlp-txn-depth-2-shan)    (rlp-txn-into-hub-src-selector-shan))
   )
  )



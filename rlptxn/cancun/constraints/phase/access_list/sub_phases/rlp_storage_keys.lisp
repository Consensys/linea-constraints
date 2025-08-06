(module rlptxn)

(defconstraint rlptxn-AL---rlp-storage-key ()
    (if-not-zero (* IS_ACCESS_LIST_STORAGE_KEY (prev DONE))
        (begin 
        (rlp-compound-bytes32    0 (rlptxn---storage-hi) (rlptxn---storage-lo))
        (if-not-zero (storage-key-list-countdown)
            (eq! (next IS_ACCESS_LIST_STORAGE_KEY) 1)
            (if-not-zero (AL-item-countdown)
                 (eq! (next IS_PREFIX_OF_ACCESS_LIST_ITEM) 1)
                 (eq! PHASE_END 1)))
        )))

(defun (rlptxn---storage-hi) cmp/EXO_DATA_1)
(defun (rlptxn---storage-lo) cmp/EXO_DATA_2)
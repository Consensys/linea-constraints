(module rlptxn)

(defconstraint rlptxn-AL---rlp-storage-key ()
    (if-not-zero (* IS_ACCESS_LIST_STORAGE_KEY (prev DONE))
        (begin 
        (rlp-compound-constraint---BYTES32    0 (rlptxn---storage-hi) (rlptxn---storage-lo))
        (if-not-zero (storage-key-list-countdown)
            (eq! (shift IS_ACCESS_LIST_STORAGE_KEY         3) 1)
            (if-not-zero (AL-item-countdown)
                 (eq! (shift IS_PREFIX_OF_ACCESS_LIST_ITEM 3) 1)
                 (eq! (shift PHASE_END                     2) 1)))
        )))

(defun (rlptxn---storage-hi) cmp/EXO_DATA_1)
(defun (rlptxn---storage-lo) cmp/EXO_DATA_2)

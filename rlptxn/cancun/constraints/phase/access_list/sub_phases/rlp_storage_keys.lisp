(module rlptxn)

(defconstraint rlptxn-AL---rlp-storage-key ()
    (if-not-zero (* IS_ACCESS_LIST_STORAGE_KEY (prev DONE))
        (begin 
        (rlp-compound-constraint---BYTES32    0 (rlptxn---access-list---storage-hi) (rlptxn---access-list---storage-lo))
        (if-not-zero (rlptxn---access-list---storage-key-list-countdown)
            (eq! (shift IS_ACCESS_LIST_STORAGE_KEY         3) 1)
            (if-not-zero (rlptxn---access-list---access-list-item-countdown)
                 (eq! (shift IS_PREFIX_OF_ACCESS_LIST_ITEM 3) 1)
                 (eq! (shift PHASE_END                     2) 1)))
        )))

(defun (rlptxn---access-list---storage-hi) cmp/EXO_DATA_1)
(defun (rlptxn---access-list---storage-lo) cmp/EXO_DATA_2)

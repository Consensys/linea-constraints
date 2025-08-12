(module rlptxn)

(defconstraint rlptxn-AL---list-storage-key ()
    (if-not-zero (* IS_PREFIX_OF_STORAGE_KEY_LIST (prev DONE))
        (begin
        (rlp-compound-constraint---BYTE_STRING_PREFIX-non-trivial  0 (length-of-concatenated-storage-keys-rlp) 1 0)
        (eq! (next IS_ACCESS_LIST_STORAGE_KEY) (storage-key-list-is-non-empty))
        (if-not-zero (storage-key-list-is-empty)
            (if-not-zero (rlptxn---AL---item-countdown)
                (eq! (next IS_PREFIX_OF_ACCESS_LIST_ITEM) 1)
                (eq! PHASE_END 1))))))

(defun (length-of-concatenated-storage-keys-rlp)            (* 33 (rlptxn---AL---storage-key-list-countdown)))
(defun (storage-key-list-is-non-empty)                      cmp/EXO_DATA_4)
(defun (storage-key-list-is-empty)                          (force-bin (- 1 (storage-key-list-is-non-empty))))

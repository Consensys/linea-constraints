(module rlptxn)

(defconstraint rlptxn-AL---rlp-prefix-tuple ()
    (if-not-zero (* IS_PREFIX_OF_ACCESS_LIST_ITEM (prev DONE))
        (rlp-compound-byte-string-non-trivial  0 (AL-item-rlp-length-countdown) 1 1)))
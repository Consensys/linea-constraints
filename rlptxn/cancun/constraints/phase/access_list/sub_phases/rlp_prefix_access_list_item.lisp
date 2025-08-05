(module rlptxn)

(defconstraint setting-rlp-access-list--item-rlp-prefix ()
    (if-not-zero (* IS_PREFIX_OF_ACCESS_LIST_ITEM (prev DONE))
        (begin
        (rlp-compound-byte-string-non-trivial  0 (AL-item-rlp-length-countdown) 1 1))))
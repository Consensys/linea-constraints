(module rlptxn)

(defconstraint rlptxn-AL---rlp-prefix-tuple ()
    (if-not-zero (* IS_PREFIX_OF_ACCESS_LIST_ITEM (prev DONE))
        (rlp-compound-constraint---BYTE_STRING_PREFIX-non-trivial  0 (rlptxn---AL---item-rlp-length-countdown) 1 1)))

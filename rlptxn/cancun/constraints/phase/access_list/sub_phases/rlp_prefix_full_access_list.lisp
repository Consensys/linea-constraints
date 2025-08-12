(module rlptxn)

(defconstraint rlptxn-AL---rlp-prefix-full-access-list ()
    (if-not-zero (is-access-list-prefix)
        (begin
        (rlp-compound-constraint---BYTE_STRING_PREFIX-non-trivial  0 (rlptxn---AL---rlp-length-countdown) 1 0)
        (eq! PHASE_END (access-list-is-empty)))))

(defun (access-list-is-non-empty)        cmp/EXO_DATA_4)
(defun (access-list-is-empty)            (- 1 (access-list-is-non-empty)))

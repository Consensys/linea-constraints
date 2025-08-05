(module rlptxn)

(defun (payload-size)                                (+ (zeros-in-payload) (nonzs-in-payload)))
(defun (zeros-in-payload)                            (prev txn/NUMBER_OF_ZERO_BYTES))
(defun (nonzs-in-payload)                            (prev txn/NUMBER_OF_NONZERO_BYTES))
(defun (rlptxn---data-first-byte-or-zero)            (* (rlptxn---data-payload-is-nonempty) (rlptxn---data-maybe-first-byte-of-payload)))
(defun (rlptxn---data-maybe-first-byte-of-payload)   (next cmp/EXO_DATA_8)) 
(defun (rlptxn---data-payload-is-nonempty)           cmp/EXO_DATA_4) 
(defun (rlptxn---data-payload-is-empty)              (force-bin (- 1 (rlptxn---data-payload-is-nonempty)))) 

(defconstraint phase-data-size-analysis-row ()
    (if-not-zero (is-payload-size-analysis-row)
        (begin
        (rlp-compound-byte-string    0 (payload-size) (rlptxn---data-first-byte-or-zero) 0 0)
        (eq! (zeros-countdown)      (zeros-in-payload))
        (eq! (nonzs-countdown)      (nonzs-in-payload))
        (if-not-zero (rlptxn---data-payload-is-empty)
            (begin 
            (vanishes! (zeros-in-payload))
            (vanishes! (nonzs-in-payload))))
        (eq! PHASE_END (rlptxn---data-payload-is-empty))))
)
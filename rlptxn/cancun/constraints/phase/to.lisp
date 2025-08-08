(module rlptxn)

(defconstraint phase-to ()
    (if-not-zero (* IS_TO TXN)
        (if-zero IS_DEPLOYMENT
            ;; message call case
            (begin
            (rlp-compound-address    1 txn/TO_HI txn/TO_LO)
            (eq! (shift PHASE_END 3) 1)
            )

            ;; deployment case
            (begin
            (set-limb                1  (*  RLP_PREFIX_INT_SHORT (^ 256 LLARGEMO)) 1)
            (eq! (shift PHASE_END 1) 1)
            )
            )))
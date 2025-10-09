(module hub)

(defun (illegal-precompiles)
 (force-bin (* PEEK_AT_SCENARIO (+ PRC_RIPEMD-160 PRC_BLAKE2f))))

(defcomputedcolumn (PROVER_ILLEGAL_TRANSACTION_DETECTED_ACC :i16 :fwd) 
    (* USER (+ (prev PROVER_ILLEGAL_TRANSACTION_DETECTED_ACC)
               (illegal-precompiles))))

(defcomputedcolumn (PROVER_ILLEGAL_TRANSACTION_DETECTED_TOT :binary :bwd) 
    (if (system-txn-numbers---user-txn-end)
    ;; finalization constraint
    (if-not-zero PROVER_ILLEGAL_TRANSACTION_DETECTED_ACC
        (eq! 1)
        (eq! 0))
    :: bwd propagation
    (eq! (* (prev USER) PROVER_ILLEGAL_TRANSACTION_DETECTED_TOT)
         (prev PROVER_ILLEGAL_TRANSACTION_DETECTED_TOT))
    ))
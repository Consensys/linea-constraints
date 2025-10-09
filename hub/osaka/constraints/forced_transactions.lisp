(module hub)

(defun (illegal-precompiles)
 (force-bin (* PEEK_AT_SCENARIO (+ scenario/PRC_RIPEMD-160 scenario/PRC_BLAKE2f))))

(defcomputedcolumn (PROVER_ILLEGAL_TRANSACTION_DETECTED_ACC :i16 :fwd) 
    (* USER (+ (prev PROVER_ILLEGAL_TRANSACTION_DETECTED_ACC)
               (illegal-precompiles))))

(defcomputedcolumn (PROVER_ILLEGAL_TRANSACTION_DETECTED :binary :bwd) 
    (if-not-zero (system-txn-numbers---user-txn-end)
    ;; finalization constraint
    (if-not-zero PROVER_ILLEGAL_TRANSACTION_DETECTED_ACC
        (eq! PROVER_ILLEGAL_TRANSACTION_DETECTED 1)
        (eq! PROVER_ILLEGAL_TRANSACTION_DETECTED 0))
    ;; bwd propagation
    (eq! (* (prev USER) PROVER_ILLEGAL_TRANSACTION_DETECTED)
         (prev PROVER_ILLEGAL_TRANSACTION_DETECTED))
    ))
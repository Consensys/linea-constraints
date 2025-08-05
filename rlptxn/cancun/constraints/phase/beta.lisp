(module rlptxn)

(defun (tw-scalar) 
       (if-zero REPLAY_PROTECTION
            (+ UNPROTECTED_V  Y_PARITY)
            (+ (* 2 txn/CHAIN_ID)
               PROTECTED_BASE_V
               Y_PARITY)))

(defconstraint phase-beta-tw ()
    (if-not-zero (* IS_BETA TXN)
        (begin
        (limb-of-lt-only  1)
        (rlp-compound-integer 1 0 (tw-scalar) (- 1 REPLAY_PROTECTION))
        )))

(defconstraint phase-beta-beta ()
    (if-not-zero (* IS_BETA TXN REPLAY_PROTECTION)
        (begin
        (limb-of-lx-only  (+ 3 1))
        (rlp-compound-integer (+ 3 1) 0 txn/CHAIN_ID 0)
        (limb-of-lx-only  (+ 3 3 1))
        (set-limb         (+ 3 3 1)
                          (+ (* RLP_PREFIX_INT_SHORT (^ 256 LLARGEMO))
                             (* RLP_PREFIX_INT_SHORT (^ 256 14))) 
                          2)
        (eq! (shift PHASE_END (+ 3 3 1)) 1)
        )))
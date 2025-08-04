(module rlptxn)

(defconstraint byte-size-countdown-are-phase-constant (:guard IS_RLP_PREFIX)
    (begin 
    (eq! LT_BYTE_SIZE_COUNTDOWN (next LT_BYTE_SIZE_COUNTDOWN))
    (eq! LX_BYTE_SIZE_COUNTDOWN (next LX_BYTE_SIZE_COUNTDOWN))))

(defproperty ct-max-is-zero-in-prefix-phase (if-not-zero IS_RLP_PREFIX (vanishes! CT_MAX)))

(defconstraint setting-first-byte-tx-type-prefix (:guard (first-row-of-rlp-prefix))
    (begin
    ;; row i+1
    (limb-of-both-lt-and-lx 1)
    (if-not-zero (next TYPE_0) 
        (discard-limb 1)
        (set-limb     1 (* txn/TX_TYPE (^ 256 LLARGEMO)) 1))
    (vanishes! (next PHASE_END))    
    ;; row i+2
    (limb-of-lt-only        2)
    (rlputils-call-byte-string-prefix-non-trivial 2 LT_BYTE_SIZE_COUNTDOWN 1)
    (vanishes! (shift PHASE_END 2))
    ;; row i+3
    (limb-of-lx-only        3)
    (rlputils-call-byte-string-prefix-non-trivial 3 LX_BYTE_SIZE_COUNTDOWN 1)
    (eq! (shift PHASE_END 3) 1)
    ))
(module rlptxn)

(defconstraint replay-protection-means-no-chain-id ()
    (if-not-zero TXN
        (if-not-zero txn/CHAIN_ID 
            (eq!       REPLAY_PROTECTION 1)
            (vanishes! REPLAY_PROTECTION))))

(defconstraint only-frontier-tx-are-not-replay-protection ()
    (if-not-zero TXN
        (if-zero TYPE_0 (eq! REPLAY_PROTECTION 1))))
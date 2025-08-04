(module rlptxn)

(defconstraint replay-protection-means-no-chain-id ()
    (if-not-zero TXN
        (if-not-zero txn/CHAIN_ID (vanishes! REPLAY_PROTECTION))))

(defproperty only-frontier-tx-are-not-replay-protection 
    (if-not-zero TXN
        (if-zero TYPE_0 (vanishes! REPLAY_PROTECTION))))
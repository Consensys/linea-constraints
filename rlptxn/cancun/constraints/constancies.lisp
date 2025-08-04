(module rlptxn)

(defpurefun (transaction-constant col) 
    (if-not (== USER_TXN_NUMBER (+ 1 (prev USER_TXN_NUMBER)))
        (remained-constant! col)))

(defconstraint transaction-constancies ()
    (begin
    (transaction-constant CFI)
    (transaction-constant REPLAY_PROTECTION)
    (transaction-constant Y_PARITY)
    (transaction-constant TYPE_0)
    (transaction-constant TYPE_1)
    (transaction-constant TYPE_2)
    (transaction-constant TYPE_3)
    (transaction-constant TYPE_4)))

(defconstraint ct-constancies ()
    (begin
    (counter-constant LT CT)
    (counter-constant LX CT)))
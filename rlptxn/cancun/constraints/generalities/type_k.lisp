(module rlptxn)

(defun (tx-type-flag-sum) 
    (force-bin (+
    TYPE_0
    TYPE_1
    TYPE_2)))

(defun (tx-type-wght-sum) 
    (+
    (* 0 TYPE_0 )
    (* 1 TYPE_1 )
    (* 2 TYPE_2 )))

(defconstraint transaction-constancies-for-type-k ()
    (begin
    (transaction-constant TYPE_0)
    (transaction-constant TYPE_1)
    (transaction-constant TYPE_2)
    ))

(defconstraint type-flag-sum-is-phase-flag-sum () (eq! (tx-type-flag-sum) (phase-flag-sum)))

(defconstraint decoding-type ()
    (if-not-zero TXN (eq! txn/TX_TYPE (tx-type-wght-sum))))
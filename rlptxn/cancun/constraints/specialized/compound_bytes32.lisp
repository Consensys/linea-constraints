(module rlptxn)

(defun (rlp-compound-bytes32    w data-hi data-lo)
    (begin 
    (eq! (shift CT_MAX w) RLP_TXN_CT_MAX_BYTES32)
    (rlputils-call-bytes32 w data-hi data-lo)
    (set-limb w         (* 160 (^ 256 LLARGEMO)) 1)
    (set-limb (+ w 1)   data-hi                  LLARGE)
    (set-limb (+ w 2)   data-lo                  LLARGE)
    ))
(module rlptxn)

(defun (rlp-compound-address    w address-hi address-lo)
    (begin 
    (eq! (shift CT_MAX          w)               RLP_TXN_CT_MAX_ADDRESS )
    (eq! (shift cmp/TRM_FLAG    w)               1)
    (eq! (shift cmp/EXO_DATA_1  w)               address-hi)
    (eq! (shift cmp/EXO_DATA_2  w)               address-lo)
    (set-limb                   w                (* 148 (^ 256 LLARGEMO)) 1)
    (set-limb              (+ w 1)               address-hi               4)
    (set-limb              (+ w 2)               address-lo               LLARGE)
    ))
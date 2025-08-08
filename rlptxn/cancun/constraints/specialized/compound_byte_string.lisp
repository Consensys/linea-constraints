(module rlptxn)

(defun (rlp-compound-byte-string-non-trivial    w length is-list must-be-non-trivial)
    (begin 
    (vanishes! (shift CT_MAX w))
    (rlputils-call-byte-string-prefix-non-trivial w length is-list)
    (conditionally-set-limb w (rlptxn---byte-string-rlp-prefix-required w) (rlptxn---byte-string-rlp-prefix w) (rlptxn---byte-string-rlp-prefix-byte-size w))
    ))

(defun (rlp-compound-byte-string    w length first-byte is-list must-be-non-trivial)
    (begin 
    (vanishes! (shift CT_MAX w))
    (rlputils-call-byte-string-prefix w length first-byte is-list)
    (conditionally-set-limb w (rlptxn---byte-string-rlp-prefix-required w) (rlptxn---byte-string-rlp-prefix w) (rlptxn---byte-string-rlp-prefix-byte-size w))
    ))

(defun (rlptxn---byte-string-bs-is-non-empty w)                      (shift cmp/EXO_DATA_4 w))
(defun (rlptxn---byte-string-rlp-prefix-required w)                  (shift cmp/EXO_DATA_5 w))
(defun (rlptxn---byte-string-rlp-prefix w)                           (shift cmp/EXO_DATA_6 w))
(defun (rlptxn---byte-string-rlp-prefix-byte-size w)                 (shift cmp/EXO_DATA_8 w))
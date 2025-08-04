(module rlptxn)

(defun (rlputils-call-integer w integer-hi integer-lo)
    (begin 
    (eq! (shift cmp/RLPUTILS_FLAG w) 1)
    (eq! (shift cmp/RLPUTILS_INST w) RLP_UTILS_INST_INTEGER)
    (eq! (shift cmp/EXO_DATA_1    w) integer-hi)
    (eq! (shift cmp/EXO_DATA_2    w) integer-lo)))

(defun (rlputils-call-byte-string-prefix-non-trivial w length is-list)
    (begin 
    (eq! (shift cmp/RLPUTILS_FLAG w) 1)
    (eq! (shift cmp/RLPUTILS_INST w) RLP_UTILS_INST_BYTE_STRING_PREFIX)
    (eq! (shift cmp/EXO_DATA_1    w) length)
    ;; (eq! (shift cmp/EXO_DATA_2    w) first-byte)
    (eq! (shift cmp/EXO_DATA_3    w) is-list)))

(defun (rlputils-call-byte-string-prefix w length first-byte is-list)
    (begin 
    (eq! (shift cmp/RLPUTILS_FLAG w) 1)
    (eq! (shift cmp/RLPUTILS_INST w) RLP_UTILS_INST_BYTE_STRING_PREFIX)
    (eq! (shift cmp/EXO_DATA_1    w) length)
    (eq! (shift cmp/EXO_DATA_2    w) first-byte)
    (eq! (shift cmp/EXO_DATA_3    w) is-list)))

(defun (rlputils-call-bytes32 w data-hi data-lo)
    (begin 
    (eq! (shift cmp/RLPUTILS_FLAG w) 1)
    (eq! (shift cmp/RLPUTILS_INST w) RLP_UTILS_INST_BYTES32)
    (eq! (shift cmp/EXO_DATA_1    w) data-hi)
    (eq! (shift cmp/EXO_DATA_2    w) data-lo)))

(defun (rlputils-call-data-pricing w limb n-bytes)
    (begin 
    (eq! (shift cmp/RLPUTILS_FLAG w) 1)
    (eq! (shift cmp/RLPUTILS_INST w) RLP_UTILS_INST_DATA_PRICING)
    (eq! (shift cmp/EXO_DATA_1    w) limb)
    (eq! (shift cmp/EXO_DATA_2    w) n-bytes)))
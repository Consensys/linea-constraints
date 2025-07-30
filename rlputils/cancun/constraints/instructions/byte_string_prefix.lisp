(module rlputils)

;; hook
(defun (bytestring--instruction-precondition) (* MACRO IS_BYTE_STRING_PREFIX))

;; shorthands

(defun (bytestring--in-byte-string-length)                             macro/DATA_1)
(defun (bytestring--in-byte-string-first-byte)                         macro/DATA_2)
(defun (bytestring--in-byte-string-is-list)                            macro/DATA_3)
(defun (bytestring--out-byte-string-is-nonempty)                       macro/DATA_4)
(defun (bytestring--out-rlp-prefix-required)                           macro/DATA_5)
(defun (bytestring--out-rlp-prefix)                                    macro/DATA_6)
(defun (bytestring--out-rlp-prefix-byte-size)                          macro/DATA_8)

(defun (base-rlp-prefix-short)                             (+ (* RLP_PREFIX_INT_SHORT  (- 1 (bytestring--in-byte-string-is-list)))
                                                              (* RLP_PREFIX_LIST_SHORT      (bytestring--in-byte-string-is-list))))
(defun (base-rlp-prefix-long)                              (+ (* RLP_PREFIX_INT_LONG   (- 1 (bytestring--in-byte-string-is-list)))
                                                              (* RLP_PREFIX_LIST_LONG       (bytestring--in-byte-string-is-list))))

;; constraints
(defconstraint bytestring--setting-ct-max (:guard (bytestring--instruction-precondition)) 
    (eq! CT_MAX CT_MAX_INST_BYTE_STRING_PREFIX))


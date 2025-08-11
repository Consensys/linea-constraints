(module rlptxn)

(defun (rlp-compound-constraint---BYTE_STRING_PREFIX-non-trivial    relOffset length is-list must-be-non-trivial)
    (begin 
      ;; setting CT_MAX
    (vanishes! (shift CT_MAX relOffset))
    ;; RLP_UTILS instruction call
    (rlputils-call-byte-string-prefix-non-trivial   relOffset
                                                    length
                                                    is-list)
    ;; enshrining the byte string's RLP prefix into the RLP string
    (conditionally-set-limb   relOffset
                              (rlptxn---BYTE_STRING_PREFIX---rlp-prefix-required    relOffset)
                              (rlptxn---BYTE_STRING_PREFIX---rlp-prefix             relOffset)
                              (rlptxn---BYTE_STRING_PREFIX---rlp-prefix-byte-size   relOffset))
    ))

(defun (rlp-compound-constraint---BYTE_STRING_PREFIX    relOffset
                                                        length
                                                        first-byte
                                                        is-list
                                                        must-be-non-trivial)
    (begin 
    (vanishes! (shift CT_MAX relOffset))
    (rlputils-call-byte-string-prefix    relOffset
                                         length
                                         first-byte
                                         is-list)
    (conditionally-set-limb    relOffset
                               (rlptxn---BYTE_STRING_PREFIX---rlp-prefix-required    relOffset)
                               (rlptxn---BYTE_STRING_PREFIX---rlp-prefix             relOffset)
                               (rlptxn---BYTE_STRING_PREFIX---rlp-prefix-byte-size   relOffset))
    ))

;; defining shorthands
(defun   (rlptxn---BYTE_STRING_PREFIX---bs-is-non-empty        relOffset) (shift   cmp/EXO_DATA_4   relOffset))
(defun   (rlptxn---BYTE_STRING_PREFIX---rlp-prefix-required    relOffset) (shift   cmp/EXO_DATA_5   relOffset))
(defun   (rlptxn---BYTE_STRING_PREFIX---rlp-prefix             relOffset) (shift   cmp/EXO_DATA_6   relOffset))
(defun   (rlptxn---BYTE_STRING_PREFIX---rlp-prefix-byte-size   relOffset) (shift   cmp/EXO_DATA_8   relOffset))

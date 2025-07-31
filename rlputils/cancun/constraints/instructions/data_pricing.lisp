(module rlputils)

;; hook
(defun (data-pricing--instruction-precondition-macro-row) (* MACRO IS_DATA_PRICING))

;; shorthands

(defun (data-pricing--in-integer-hi)                                     macro/DATA_1)
(defun (data-pricing--in-integer-lo)                                     macro/DATA_2)
(defun (data-pricing--out-integer-is-nonzero)                            macro/DATA_3)
(defun (data-pricing--out-integer-has-nonzero-hi-part)                   macro/DATA_4)
(defun (data-pricing--out-rlp-prefix-required)                           macro/DATA_5)
(defun (data-pricing--out-rlp-prefix)                                    macro/DATA_6)
(defun (data-pricing--out-leading-limb-left-shifted)                     macro/DATA_7)
(defun (data-pricing--out-leading-limb-byte-size)                        macro/DATA_8)
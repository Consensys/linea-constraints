(module rlputils)

;; hook
(defun (integer-instruction-precondition) (* MACRO IS_INTEGER))

;; shorthands

(defun (in-integer-hi)                                     macro/DATA_1)
(defun (in-integer-lo)                                     macro/DATA_2)
(defun (out-integer-is-nonzero)                            macro/DATA_3)
(defun (out-integer-has-nonzero-hi-part)                   macro/DATA_4)
(defun (out-rlp-prefix-required)                           macro/DATA_5)
(defun (out-rlp-prefix)                                    macro/DATA_6)
(defun (out-leading-limb-left-shifted)                     macro/DATA_7)
(defun (out-leading-limb-byte-size)                        macro/DATA_8)

;; constraints
(defconstraint setting-ct-max (:guard (integer-instruction-precondition)) 
    (eq! CT_MAX CT_MAX_INST_INTEGER))

;; first row
(defconstraint first-wcp-call   (:guard (integer-instruction-precondition))  (wcp-call-is-zero 1 (in-integer-hi) (in-integer-lo)))

(defun (integer-is-zero)                                   (shift compt/RES 1))
(defun (integer-is-nonzero)                                (- 1 (integer-is-zero)))

;;second row
(defconstraint second-wcp-call  (:guard (integer-instruction-precondition))  (wcp-call-gt      2  0               (in-integer-hi) 0))

(defun (integer-hi-is-nonzero)                             (shift compt/RES 2))
(defun (integer-hi-is-zero)                                (- 1 (integer-hi-is-nonzero)))
(defun (integer-hi-byte-size)                              (+ (shift compt/WCP_CT_MAX 2) (integer-hi-is-nonzero)))

;; third row
(defconstraint third-wcp-call   (:guard (integer-instruction-precondition))  (wcp-call-lt      3  0               (in-integer-lo) RLP_PREFIX_INT_SHORT))

(defun (integer-is-lt-one-two-eight)                       (* (integer-is-zero) (shift compt/RES 3)))
(defun (integer-is-geq-one-two-eight)                      (- 1 (integer-is-lt-one-two-eight)))
(defun (integer-lo-byte-size)                              (+ (shift compt/WCP_CT_MAX 3) (integer-is-nonzero)))
(defun (leading-limb-byte-size)                            (+ (* (integer-hi-is-nonzero) (integer-hi-byte-size))
                                                              (* (integer-hi-is-zero)    (integer-lo-byte-size))))
(defun (integer-byte-size)                                 (+ (leading-limb-byte-size) (* (integer-is-nonzero) LLARGE)))

;; setting results
(defconstraint setting-shift-factor (:guard (integer-instruction-precondition)) (conditionally-get-shifting-factor 3 (integer-hi-is-nonzero) (leading-limb-byte-size)))

(defun (shifting-factor)                                   (shift compt/SHF_POWER 3))
(defun (leading-limb)                                      (+ (* (integer-hi-is-nonzero) (in-integer-hi))
                                                              (* (integer-hi-is-zero)    (in-integer-lo))))
(defun (leading-limb-left-shifted)                         (* (shifting-factor) (leading-limb)))

(defconstraint setting-result (:guard (integer-instruction-precondition))
    (begin 
    (eq! (out-integer-is-nonzero)               (integer-is-nonzero))
    (eq! (out-integer-has-nonzero-hi-part)      (integer-hi-is-nonzero))
    (eq! (out-rlp-prefix-required)              (+ (integer-is-zero) (integer-is-geq-one-two-eight)))    
    (eq! (out-rlp-prefix)                       (* (out-rlp-prefix-required) (+ RLP_PREFIX_INT_SHORT (integer-byte-size)) (^ 256 LLARGEMO)))
    (eq! (out-leading-limb-left-shifted)        (leading-limb-left-shifted))
    (eq! (out-leading-limb-byte-size)           (leading-limb-byte-size))
    ))  
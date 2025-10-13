(module oob)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;   OOB_INST_MODEXP_xbs  ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defconst
  EIP_7823_MODEXP_UPPER_BYTE_SIZE_BOUND_PLUS_ONE     (+ EIP_7823_MODEXP_UPPER_BYTE_SIZE_BOUND 1)
  )


(defun (prc-modexp-xbs---standard-precondition)                        IS_MODEXP_XBS)
(defun (prc-modexp-xbs---xbs-hi)                                      [DATA   1])
(defun (prc-modexp-xbs---xbs-lo)                                      [DATA   2])
(defun (prc-modexp-xbs---ybs-lo)                                      [DATA   3])
(defun (prc-modexp-xbs---compute-max)                     (force-bin  [DATA   4]))
(defun (prc-modexp-xbs---max-xbs-ybs)                                 [DATA   7])
(defun (prc-modexp-xbs---xbs-nonzero)                                 [DATA   8])
(defun (prc-modexp-xbs---xbs-within-bounds)               (force-bin  [DATA   9]))
(defun (prc-modexp-xbs---xbs-out-of-bounds)               (force-bin  [DATA  10]))
(defun (prc-modexp-xbs---xbs-is-LEQ-EIP-7823-upper-bound)              OUTGOING_RES_LO)
(defun (prc-modexp-xbs---xbs-is-GT-EIP-7823-upper-bound)        (-  1  (prc-modexp-xbs---xbs-is-LEQ-EIP-7823-upper-bound)))
(defun (prc-modexp-xbs---result-of-comparison)                  (next  OUTGOING_RES_LO)) ;; ""

(defconstraint prc-modexp-xbs---compare-xbs-against-EIP-7823-upper-bound
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (call-to-LT   0
                             (prc-modexp-xbs---xbs-hi)
                             (prc-modexp-xbs---xbs-lo)
                             0
                             EIP_7823_MODEXP_UPPER_BYTE_SIZE_BOUND_PLUS_ONE
                             ))

(defconstraint prc-modexp-xbs---compare-xbs-against-ybs
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (call-to-LT   1
                             0
                             (prc-modexp-xbs---xbs-lo)
                             0
                             (prc-modexp-xbs---ybs-lo)
                             ))

(defconstraint prc-modexp-xbs---check-xbs-is-zero
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (call-to-ISZERO  2
                                0
                                (prc-modexp-xbs---xbs-lo)
                                ))

(defconstraint additional-prc-modexp-xbs
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (is-binary   (prc-modexp-xbs---compute-max)))

(defconstraint prc-modexp-xbs---justify-hub-predictions---sans-max-computation
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (if-zero (prc-modexp-xbs---compute-max)
                        (begin (vanishes! (prc-modexp-xbs---max-xbs-ybs))
                               (vanishes! (prc-modexp-xbs---xbs-nonzero))
                               )))

(defconstraint prc-modexp-xbs---justify-hub-predictions---with-max-computation
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (if-not-zero (prc-modexp-xbs---compute-max)
                            (begin (eq!     (prc-modexp-xbs---xbs-nonzero)
                                            (- 1 (shift OUTGOING_RES_LO 2)))
                                   (if-zero (prc-modexp-xbs---result-of-comparison)
                                            ;; result-of-comparison ≡ false case
                                            (eq! (prc-modexp-xbs---max-xbs-ybs) (prc-modexp-xbs---xbs-lo))
                                            ;; result-of-comparison ≡ true case
                                            (eq! (prc-modexp-xbs---max-xbs-ybs) (prc-modexp-xbs---ybs-lo))
                                            ))))

(defconstraint prc-modexp-xbs---justify-hub-predictions---bounds-bits
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (begin   (eq!   (prc-modexp-xbs---xbs-within-bounds)  (prc-modexp-xbs---xbs-is-LEQ-EIP-7823-upper-bound))
                        (eq!   (prc-modexp-xbs---xbs-out-of-bounds)  (prc-modexp-xbs---xbs-is-GT-EIP-7823-upper-bound))
                        ))


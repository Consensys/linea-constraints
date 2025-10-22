(module oob)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;   OOB_INST_MODEXP_xbs  ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defconst
  EIP_7823_MODEXP_UPPER_BYTE_SIZE_BOUND_PLUS_ONE     (+ EIP_7823_MODEXP_UPPER_BYTE_SIZE_BOUND 1)

  ROFF___MODEXP_XBS___XBS_VS_EIP_7823_UPPER_BOUND 0
  ROFF___MODEXP_XBS___XBS_VS_YBS                  1
  ROFF___MODEXP_XBS___XBS_ISZERO_CHECK            2
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
;; ""


(defconstraint    prc-modexp-xbs---compare-xbs-against-EIP-7823-upper-bound
                  (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (call-to-LT   ROFF___MODEXP_XBS___XBS_VS_EIP_7823_UPPER_BOUND
                                (prc-modexp-xbs---xbs-hi)
                                (prc-modexp-xbs---xbs-lo)
                                0
                                EIP_7823_MODEXP_UPPER_BYTE_SIZE_BOUND_PLUS_ONE
                                ))

(defconstraint    prc-modexp-xbs---compare-xbs-against-ybs
                  (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (call-to-LT   ROFF___MODEXP_XBS___XBS_VS_YBS
                                0
                                (prc-modexp-xbs---xbs-lo)
                                0
                                (prc-modexp-xbs---ybs-lo)
                                ))

(defconstraint    prc-modexp-xbs---check-xbs-is-zero
                  (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (call-to-ISZERO    ROFF___MODEXP_XBS___XBS_ISZERO_CHECK
                                     0
                                     (prc-modexp-xbs---xbs-lo)
                                     ))


(defun (prc-modexp-xbs---xbs-is-LEQ-EIP-7823-upper-bound)      (shift   OUTGOING_RES_LO   ROFF___MODEXP_XBS___XBS_VS_EIP_7823_UPPER_BOUND ))
(defun (prc-modexp-xbs---result-of-comparison)                 (shift   OUTGOING_RES_LO   ROFF___MODEXP_XBS___XBS_VS_YBS                  ))
(defun (prc-modexp-xbs---xbs-is-zero)                          (shift   OUTGOING_RES_LO   ROFF___MODEXP_XBS___XBS_ISZERO_CHECK            ))
(defun (prc-modexp-xbs---xbs-is-GT-EIP-7823-upper-bound)        (-  1  (prc-modexp-xbs---xbs-is-LEQ-EIP-7823-upper-bound)))



(defconstraint    prc-modexp-xbs---binarity-sanity-check
                  (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (is-binary   (prc-modexp-xbs---compute-max)))

(defconstraint    prc-modexp-xbs---justify-hub-predictions---xbs-nonzero
                  (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (eq!   (prc-modexp-xbs---xbs-is-zero)
                         (-   1   (prc-modexp-xbs---xbs-nonzero))
                         ))

(defconstraint    prc-modexp-xbs---justify-hub-predictions---sans-max-computation
                  (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (if-zero   (prc-modexp-xbs---compute-max)
                             (vanishes! (prc-modexp-xbs---max-xbs-ybs))
                             ))

(defconstraint    prc-modexp-xbs---justify-hub-predictions---with-max-computation
                  (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (if-not-zero   (prc-modexp-xbs---compute-max)
                                 (if-zero   (prc-modexp-xbs---result-of-comparison)
                                            ;; result-of-comparison ≡ faux case
                                            (eq! (prc-modexp-xbs---max-xbs-ybs) (prc-modexp-xbs---xbs-lo))
                                            ;; result-of-comparison ≡ true case
                                            (eq! (prc-modexp-xbs---max-xbs-ybs) (prc-modexp-xbs---ybs-lo))
                                            )))

(defconstraint    prc-modexp-xbs---justify-hub-predictions---bounds-bits
                  (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (begin   (eq!   (prc-modexp-xbs---xbs-within-bounds)  (prc-modexp-xbs---xbs-is-LEQ-EIP-7823-upper-bound))
                           (eq!   (prc-modexp-xbs---xbs-out-of-bounds)  (prc-modexp-xbs---xbs-is-GT-EIP-7823-upper-bound))
                           ))


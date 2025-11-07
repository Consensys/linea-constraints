(module oob)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;   OOB_INST_MODEXP_xbs  ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (prc-modexp-xbs---standard-precondition)                 IS_MODEXP_XBS)
(defun (prc-modexp-xbs---xbs-hi)                                [ DATA    1 ])
(defun (prc-modexp-xbs---xbs-lo)                                [ DATA    2 ])
(defun (prc-modexp-xbs---ybs-lo)                                [ DATA    3 ])
(defun (prc-modexp-xbs---compute-max)                           [ DATA    4 ])
(defun (prc-modexp-xbs---max-xbs-ybs)                           [ DATA    7 ])
(defun (prc-modexp-xbs---xbs-nonzero)                           [ DATA    8 ])
(defun (prc-modexp-xbs---xbs-within-bounds)                     [ DATA    9 ])
(defun (prc-modexp-xbs---xbs-out-of-bounds)                     [ DATA   10 ])

(defun (prc-modexp-xbs---xbs-is-LEQ-the-MODEXP-upper-bound)     (shift   OUTGOING_RES_LO   0)) ;; ""
(defun (prc-modexp-xbs---xbs-is-LT-ybs)                         (shift   OUTGOING_RES_LO   1)) ;; ""
(defun (prc-modexp-xbs---xbs-lo-is-zero)                        (shift   OUTGOING_RES_LO   2)) ;; ""


(defconstraint prc-modexp-xbs---compare-xbs-against-MODEXP-upper-byte-size-bound
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               (call-to-LT   0
                             (prc-modexp-xbs---xbs-hi)
                             (prc-modexp-xbs---xbs-lo)
                             0
                             (+  EIP_7823_MODEXP_UPPER_BYTE_SIZE_BOUND  1)
                             ))


(defun   (prc-modexp-xbs---xbs-normalized)   (*  (prc-modexp-xbs---xbs-lo)   (prc-modexp-xbs---xbs-is-LEQ-the-MODEXP-upper-bound) ) )
(defun   (prc-modexp-xbs---ybs-normalized)   (*  (prc-modexp-xbs---ybs-lo)   (prc-modexp-xbs---xbs-is-LEQ-the-MODEXP-upper-bound) ) )


(defconstraint   prc-modexp-xbs---compare-xbs-against-ybs
                 (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (call-to-LT   1
                               0
                               (prc-modexp-xbs---xbs-normalized)
                               0
                               (prc-modexp-xbs---ybs-normalized)
                               ))


(defconstraint prc-modexp-xbs---check-xbs-is-zero
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (call-to-ISZERO   2
                                 0
                                 (prc-modexp-xbs---xbs-normalized)
                                 ))


(defconstraint additional-prc-modexp-xbs
               (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (begin (or! (eq! 0 (prc-modexp-xbs---compute-max)) (eq! 1 (prc-modexp-xbs---compute-max)))
                      (eq! (prc-modexp-xbs---xbs-is-LEQ-the-MODEXP-upper-bound) 1)))


(defconstraint   prc-modexp-xbs---justifying-hub-predictions---various-prediction-bits
                 (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (begin   (eq!   (prc-modexp-xbs---xbs-nonzero)         (- 1 (prc-modexp-xbs---xbs-lo-is-zero)                     ))
                          (eq!   (prc-modexp-xbs---xbs-within-bounds)   (prc-modexp-xbs---xbs-is-LEQ-the-MODEXP-upper-bound)        )
                          (eq!   (prc-modexp-xbs---xbs-out-of-bounds)   (- 1 (prc-modexp-xbs---xbs-is-LEQ-the-MODEXP-upper-bound))  )
                          ))


(defconstraint   prc-modexp-xbs---justifying-hub-predictions---setting-the-value-of-max-xbs-ybs
                 (:guard (* (assumption---fresh-new-stamp) (prc-modexp-xbs---standard-precondition)))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (if-zero    (prc-modexp-xbs---compute-max)
                             ;; comupte_max = false
                             (vanishes!   (prc-modexp-xbs---max-xbs-ybs))
                             ;; comupte_max = false
                             (if-zero     (prc-modexp-xbs---xbs-is-LEQ-the-MODEXP-upper-bound)
                                          ;; false case
                                          (vanishes!   (prc-modexp-xbs---max-xbs-ybs))
                                          ;; true case
                                          (if-zero     (prc-modexp-xbs---xbs-is-LT-ybs)
                                                       ;; false case
                                                       (eq!   (prc-modexp-xbs---max-xbs-ybs)
                                                              (prc-modexp-xbs---xbs-lo))
                                                       ;; true case
                                                       (eq!   (prc-modexp-xbs---max-xbs-ybs)
                                                              (prc-modexp-xbs---ybs-lo))
                                                       ))))

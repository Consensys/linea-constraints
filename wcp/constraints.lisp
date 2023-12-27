(module wcp)

(defpurefun (if-eq-else A B then else)
  (if-zero (- A B)
           then
           else))

;; opcode values
(defconst 
  LEQ      0x0E
  GEQ      0x0F
  LT       16
  GT       17
  SLT      18
  SGT      19
  EQ_      20
  ISZERO   21
  LLARGE   16
  LLARGEMO 15)

(defconstraint binarities ()
  (begin (is-binary NEG_1)
         (is-binary NEG_2)
         (is-binary RES)
         (is-binary BITS)
         (is-binary BIT_1)
         (is-binary BIT_2)
         (is-binary BIT_3)
         (is-binary BIT_4)
         (is-binary IS_ISZERO)
         (is-binary IS_EQ)
         (is-binary IS_LT)
         (is-binary IS_GT)
         (is-binary IS_LEQ)
         (is-binary IS_GEQ)
         (is-binary IS_SLT)
         (is-binary IS_SGT)))

(defun (flag-sum)
  (+ IS_LT IS_GT IS_SLT IS_SGT IS_EQ IS_ISZERO IS_GEQ IS_LEQ))

(defun (weight-sum)
  (+ (* LT IS_LT)
     (* GT IS_GT)
     (* SLT IS_SLT)
     (* SGT IS_SGT)
     (* EQ_ IS_EQ)
     (* ISZERO IS_ISZERO)
     (* GEQ IS_GEQ)
     (* LEQ IS_LEQ)))

(defun (one-line-inst)
  (+ IS_EQ IS_ISZERO))

(defun (multi-line-inst)
  (+ IS_SLT IS_SGT))

(defun (variable-length-inst)
  (+ IS_LT IS_GT IS_LEQ IS_GEQ))

(defconstraint inst-decoding ()
  (if-zero STAMP
           (vanishes! (flag-sum))
           (eq! (flag-sum) 1)))

(defconstraint setting-flag ()
  (begin (eq! INST (weight-sum))
         (eq! OLI (one-line-inst))
         (eq! MLI (multi-line-inst))
         (eq! VLI (variable-length-inst))))

(defconstraint counter-constancies ()
  (begin (counter-constancy CT ARG_1_HI)
         (counter-constancy CT ARG_1_LO)
         (counter-constancy CT ARG_2_HI)
         (counter-constancy CT ARG_2_LO)
         (counter-constancy CT RES)
         (counter-constancy CT INST)
         (counter-constancy CT CT_MAX)
         (counter-constancy CT BIT_3)
         (counter-constancy CT BIT_4)
         (counter-constancy CT NEG_1)
         (counter-constancy CT NEG_2)))

(defconstraint first-row (:domain {0})
  (vanishes! STAMP))

(defconstraint stamp-increments ()
  (any! (will-remain-constant! STAMP) (will-inc! STAMP 1)))

(defconstraint counter-reset ()
  (if-not-zero (will-remain-constant! STAMP)
               (vanishes! (next CT))))

(defconstraint setting-ct-max ()
  (begin (if-eq OLI 1 (vanishes! CT_MAX))
         (if-eq MLI 1 (eq! CT_MAX LLARGEMO))))

(defconstraint heartbeat (:guard STAMP)
  (begin (if-eq-else CT CT_MAX (will-inc! STAMP 1) (will-inc! CT 1))
         (eq! (* WITNESS (- LLARGE CT))
              1)))

(defconstraint lastRow (:domain {-1})
  (eq! CT CT_MAX))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    2.6 byte decompositions   ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; byte decompositions
(defconstraint byte_decompositions ()
  (begin (byte-decomposition CT ACC_1 BYTE_1)
         (byte-decomposition CT ACC_2 BYTE_2)
         (byte-decomposition CT ACC_3 BYTE_3)
         (byte-decomposition CT ACC_4 BYTE_4)
         (byte-decomposition CT ACC_5 BYTE_5)
         (byte-decomposition CT ACC_6 BYTE_6)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                         ;;
;;    2.7 BITS and sign bit constraints    ;;
;;                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint bits_and_negs (:guard MLI)
  (if-eq CT CT_MAX
         (begin (eq! BYTE_1 (first-eight-bits-bit-dec))
                (eq! BYTE_3 (last-eight-bits-bit-dec))
                (eq! NEG_1
                     (shift BITS (- LLARGEMO)))
                (eq! NEG_2
                     (shift BITS (- 8))))))

(defun (first-eight-bits-bit-dec)
  (+ (* 128
        (shift BITS (- 15)))
     (* 64
        (shift BITS (- 14)))
     (* 32
        (shift BITS (- 13)))
     (* 16
        (shift BITS (- 12)))
     (* 8
        (shift BITS (- 11)))
     (* 4
        (shift BITS (- 10)))
     (* 2
        (shift BITS (- 9)))
     (shift BITS (- 8))))

(defun (last-eight-bits-bit-dec)
  (+ (* 128
        (shift BITS (- 7)))
     (* 64
        (shift BITS (- 6)))
     (* 32
        (shift BITS (- 5)))
     (* 16
        (shift BITS (- 4)))
     (* 8
        (shift BITS (- 3)))
     (* 4
        (shift BITS (- 2)))
     (* 2
        (shift BITS (- 1)))
     BITS))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    2.6 target constraints    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint target-constraints ()
  (begin (if-not-zero STAMP
                      (begin (if-eq-else ARG_1_HI ARG_2_HI (= BIT_1 1) (= BIT_1 0))
                             (if-eq-else ARG_1_LO ARG_2_LO (= BIT_2 1) (= BIT_2 0))))
         (if-eq (+ MLI VLI) 1
                (if-eq CT CT_MAX
                       (begin (= ACC_1 ARG_1_HI)
                              (= ACC_2 ARG_1_LO)
                              (= ACC_3 ARG_2_HI)
                              (= ACC_4 ARG_2_LO)
                              (= ACC_5
                                 (- (* (- (* 2 BIT_3) 1)
                                       (- ARG_1_HI ARG_2_HI))
                                    BIT_3))
                              (= ACC_6
                                 (- (* (- (* 2 BIT_4) 1)
                                       (- ARG_1_LO ARG_2_LO))
                                    BIT_4)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    2.7 result constraints    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eq_ = [[1]] . [[2]]
;; gt_ = [[3]] + [[1]] . [[4]]
;; lt_ = 1 - eq - gt
(defun (eq_)
  (* BIT_1 BIT_2))

(defun (gt_)
  (+ BIT_3 (* BIT_1 BIT_4)))

(defun (lt_)
  (- 1 (eq_) (gt_)))

;; 2.7.2
(defconstraint result ()
  (begin (if-eq OLI 1 (eq! RES (eq_)))
         (if-eq IS_LT 1 (eq! RES (lt_)))
         (if-eq IS_GT 1 (eq! RES (gt_)))
         (if-eq IS_LEQ 1
                (eq! RES (+ (lt_) (eq_))))
         (if-eq IS_GEQ 1
                (eq! RES (+ (lt_) (eq_))))
         (if-eq IS_LT 1 (eq! RES (lt_)))
         (if-eq IS_SLT 1
                (if-eq-else NEG_1 NEG_2 (eq! RES (lt_)) (eq! RES NEG_1)))
         (if-eq IS_SGT 1
                (if-eq-else NEG_1 NEG_2 (eq! RES (lt_)) (eq! RES NEG_1)))))



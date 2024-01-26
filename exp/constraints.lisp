(module exp)

(defconst 
  G_EXPBYTES              50
  EXP_EXPLOG              1
  EXP_MODEXPLOG           2
  MAX_CT_CMPTN_EXP_LOG    15
  MAX_CT_MACRO_EXP_LOG    0
  MAX_CT_PRPRC_EXP_LOG    0
  MAX_CT_CMPTN_MODEXP_LOG 15
  MAX_CT_MACRO_MODEXP_LOG 0
  MAX_CT_PRPRC_MODEXP_LOG 3) ;; decide values

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.1 Shorthands           ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (flag_sum_perspective)
  (+ CMPTN MACRO PRPRC))

(defun (flag_sum_macro)
  (+ IS_EXP_LOG IS_MODEXP_LOG))

(defun (wght_sum_macro)
  (+ (* EXP_EXPLOG IS_EXP_LOG) (* EXP_MODEXPLOG IS_MODEXP_LOG)))

(defun (maxct_sum)
  (+ (* CMPTN
        (+ (* MAX_CT_CMPTN_EXP_LOG IS_EXP_LOG) (* MAX_CT_CMPTN_MODEXP_LOG IS_MODEXP_LOG)))
     (* MACRO
        (+ (* MAX_CT_MACRO_EXP_LOG IS_EXP_LOG) (* MAX_CT_MACRO_MODEXP_LOG IS_MODEXP_LOG)))
     (* PRPRC
        (+ (* MAX_CT_PRPRC_EXP_LOG IS_EXP_LOG) (* MAX_CT_PRPRC_MODEXP_LOG IS_MODEXP_LOG)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.2 binary constraints   ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint binary-constraints ()
  (begin (is-binary IS_EXP_LOG)
         (is-binary IS_MODEXP_LOG)
         (is-binary CMPTN)
         (is-binary MACRO)
         (is-binary PRPRC)
         (is-binary (flag_sum_perspective))
         (is-binary (flag_sum_macro))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;    2.3 Flag sum perspectives  ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint flag-sum-perspective-padding-non-padding ()
  (if-zero STAMP
           (vanishes! (flag_sum_perspective))
           (eq! (flag_sum_perspective) 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;    2.4 Instruction decoding   ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint instruction-decoding-padding-non-padding ()
  (if-zero STAMP
           (vanishes! (flag_sum_macro))
           (eq! (flag_sum_macro) 1)))

(defconstraint instruction-decoding-exp-inst (:perspective macro-instruction)
  (eq! EXP_INST (wght_sum_macro)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.5 Constancies          ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint stamp-constancy ()
  (begin (stamp-constancy STAMP IS_EXP_LOG)
         (stamp-constancy STAMP IS_MODEXP_LOG)))

(defconstraint counter-constancy ()
  (begin (counter-constancy CT CMPTN)
         (counter-constancy CT MACRO)
         (counter-constancy CT PRPRC)))

;; perspective constancy constraint (TODO: add to stdlib.lisp)
(defpurefun ((perspective-constancy :@loob) PERSPECTIVE_SELECTOR X)
  (if-not-zero (and PERSPECTIVE_SELECTOR (prev PERSPECTIVE_SELECTOR))
               (remained-constant! X)))

(defconstraint computation-constancy (:perspective computation)
  (begin (perspective-constancy CMPTN PLT_JMP)
         (perspective-constancy CMPTN MSNZB)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    3.2 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1
(defconstraint first-row (:domain {0})
  (vanishes! STAMP))

;; 2
(defconstraint stamp-vanishing-values ()
  (if-zero STAMP
           (vanishes! CT)))

;; 3
(defconstraint stamp-increments ()
  (eq! (next STAMP)
       (+ STAMP
          (* (next CMPTN) (- 1 CMPTN)))))

;; 4
(defconstraint maxct ()
  (eq! CT_MAX (maxct_sum)))

;; 5
(defconstraint unallowed-transitions ()
  (+ (* CMPTN (next PRPRC))
     (* MACRO
        (+ (next MACRO) (next CMPTN)))
     (* PRPRC (next MACRO))))

;; 6
(defconstraint allowed-transitions ()
  (if-not-zero STAMP
               (if-eq CT CT_MAX
                      (eq! (+ (* CMPTN (next MACRO))
                              (* MACRO (next PRPRC))
                              (* PRPRC (next CMPTN)))
                           1))))

;; 7
(defconstraint instruction-counter-cycle ()
  (if-eq-else CT CT_MAX
              (eq! (next CT) 0)
              (will-inc! CT 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.7 Byte decomposition   ;;
;;        constraints          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint byte-decompositions (:perspective computation)
  (begin (byte-decomposition CT RAW_ACC RAW_BYTE)
         (byte-decomposition CT TRIM_ACC TRIM_BYTE)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.8 Byte decomposition   ;;
;;        constraints          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bit decomposition constraint (TODO: add to stdlib.lisp)
(defpurefun (bit-decomposition ct acc bits)
  (if-zero ct
           (eq! acc bits)
           (eq! acc
                (+ (* 2 (prev acc))
                   bits))))

(defconstraint bit-decompositions (:perspective computation)
  (bit-decomposition CT ACC_MSNZB BIT_MSNZB))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.9 Plateau bit          ;;
;;        constraints          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint plateau-constraints (:perspective computation)
  (plateau-constraint CT PLT_BIT PLT_JMP))

;; deprecated
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.1 The NZEXP column     ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint nzexp ()
  (if-not-zero EXPNT_HI
               (eq! NZEXP 1)
               (if-not-zero EXPNT_HI
                            (eq! NZEXP 1)
                            (vanishes! NZEXP))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.4 PBIT and PACC        ;;
;;        constraints          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint pacc-pbit ()
  (if-zero PACC
           (vanishes! PBIT)
           (eq! PBIT 1)))

(defconstraint pbit-pacc-counting ()
  (if-zero CT
           (eq! PACC PBIT)
           (eq! PACC
                (+ (+ (prev PACC) PBIT)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;    2.6 Target constraints     ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint target-1 ()
  (if-eq CT 15
         (if-not-zero EXPNT_HI
                      (begin (eq! EXPNT_HI ACC)
                             (eq! DYNCOST
                                  (* G_EXPBYTES (+ PACC 16))))
                      (begin (eq! EXPNT_LO ACC)
                             (eq! DYNCOST (* G_EXPBYTES PACC))))))



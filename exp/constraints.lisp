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
;;    2.3 Instruction decoding   ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint instruction-decoding-padding-non-padding ()
  (if-zero STAMP
           (vanishes! (flag_sum_macro))
           (eq! (flag_sum_macro) 1)))

(defconstraint instruction-decoding-exp-inst (:perspective macro-instruction)
  (eq! EXP_INST (wght_sum_macro)))

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
           (begin (vanishes! CT)
                  (vanishes! DYNCOST)
                  (vanishes! NZEXP)
                  (vanishes! EXPNT_HI)
                  (vanishes! EXPNT_LO))))

;; 3
(defconstraint stamp-increments ()
  (any! (will-remain-constant! STAMP) (will-inc! STAMP 1)))

;; 4
(defconstraint counter-reset ()
  (if-not-zero (will-remain-constant! STAMP)
               (vanishes! (next CT))))

;; 5
(defconstraint instruction-counter-cycle ()
  (if-not-zero STAMP
               (if-zero NZEXP
                        (will-inc! STAMP 1)
                        (if-eq-else CT 15 (will-inc! STAMP 1) (will-inc! CT 1)))))

;; 6
(defconstraint final-row (:domain {-1})
  (if-not-zero NZEXP
               (eq! CT 15)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.3 counter constancy    ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint counter-constancy ()
  (begin (counter-constancy CT EXPNT_HI)
         (counter-constancy CT EXPNT_LO)
         (counter-constancy CT DYNCOST)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.4 BYTE and ACC         ;;
;;        constraints          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint nzexp-byte ()
  (if-zero NZEXP
           (vanishes! BYTE)))

(defconstraint acc-byte ()
  (if-zero CT
           (eq! ACC BYTE)
           (eq! ACC
                (+ (* 256 (prev ACC) BYTE)))))

;; (defconstraint byte-decompositions ()
;;  (byte-decomposition CT ACC BYTE))
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



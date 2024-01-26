(module exp)

(defconst 
  G_EXPBYTES              50
  EXP_EXPLOG              1 ;; ?
  EXP_MODEXPLOG           2 ;; ?
  MAX_CT_CMPTN_EXP_LOG    15
  MAX_CT_MACRO_EXP_LOG    0
  MAX_CT_PRPRC_EXP_LOG    0
  MAX_CT_CMPTN_MODEXP_LOG 15
  MAX_CT_MACRO_MODEXP_LOG 0
  MAX_CT_PRPRC_MODEXP_LOG 3
  LT                      0x10
  EQ                      0x14
  ISZERO                  0x15)

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
  (vanishes! (+ (* CMPTN (next PRPRC))
                (* MACRO
                   (+ (next MACRO) (next CMPTN)))
                (* PRPRC (next MACRO)))))

;; 6
(defconstraint allowed-transitions ()
  (if (and (neq STAMP 0) (eq CT CT_MAX))
      (eq! (+ (* CMPTN (next MACRO))
              (* MACRO (next PRPRC))
              (* PRPRC (next CMPTN)))
           1)))

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
;;    3.8 Bit decomposition   ;;
;;        constraints          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bit decomposition constraint (TODO: add to stdlib.lisp)
(defpurefun (bit-decomposition ct acc bits)
  (if-zero ct
           (eq! acc bits)
           (eq! acc
                (+ (* 2 (prev acc))
                   bits))))

(defconstraint bit-decompositions (:perspective computation :guard IS_MODEXP_LOG)
  (bit-decomposition CT ACC_MSNZB BIT_MSNZB))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    3.9 Plateau bit          ;;
;;        constraints          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint plateau-constraints (:perspective computation :guard IS_MODEXP_LOG)
  (plateau-constraint CT PLT_BIT PLT_JMP))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;    3.10 Counting nonzeroness  ;;
;;         constraints           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; non zero bit constraint 
(defpurefun (non-zero-bit x nzb)
  (if-zero x
           (vanishes! nzb)
           (eq! nzb 1)))

;; counting nonzeroness constraint 
(defpurefun (counting-nonzeroness ct nzb_acc nzb)
  (if-zero ct
           (eq! nzb_acc nzb)
           (eq! nzb_acc
                (+ (prev nzb_acc) nzb))))

(defconstraint filter-raw (:perspective computation)
  (eq! TRIM_BYTE
       (* RAW_BYTE (- 1 PLT_BIT))))

(defconstraint counting-nonzeroness-trim (:perspective computation)
  (begin (non-zero-bit TRIM_ACC TANZB)
         (counting-nonzeroness CT TANZB_ACC TANZB)))

(defconstraint counting-nonzeroness-msnzb (:perspective computation)
  (begin (non-zero-bit ACC_MSNZB MANZB)
         (counting-nonzeroness CT MANZB_ACC MANZB)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                    ;;
;;    3.11 Most significant           ;;
;;         non-zero byte constraints  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint most-significant-non-zero-byte (:perspective computation :guard IS_MODEXP_LOG)
  (begin (if (and (eq CT 0) (neq TANZB_ACC 0))
             (eq! MSNZB TRIM_BYTE))
         (if (and (neq CT 0)
                  (and (neq TANZB_ACC 0)
                       (eq (prev TANZB_ACC) 0)))
             (eq! MSNZB TRIM_BYTE))
         (if (and (neq CT 0) (eq TANZB_ACC 0))
             (vanishes! MSNZB))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                    ;;
;;    3.12 Word comparisons utilities ;;
;;                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (callToLT k a b c d)
  (begin (eq! (shift preprocessing/WCP_FLAG k) 1)
         (eq! (shift preprocessing/WCP_INST k) LT)
         (eq! (shift preprocessing/WCP_ARG_1_HI k) a)
         (eq! (shift preprocessing/WCP_ARG_1_LO k) b)
         (eq! (shift preprocessing/WCP_ARG_2_HI k) c)
         (eq! (shift preprocessing/WCP_ARG_2_LO k) d)))

(defun (callToEQ k a b c d)
  (begin (eq! (shift preprocessing/WCP_FLAG k) 1)
         (eq! (shift preprocessing/WCP_INST k) EQ)
         (eq! (shift preprocessing/WCP_ARG_1_HI k) a)
         (eq! (shift preprocessing/WCP_ARG_1_LO k) b)
         (eq! (shift preprocessing/WCP_ARG_2_HI k) c)
         (eq! (shift preprocessing/WCP_ARG_2_LO k) d)))

(defun (callToISZERO k a b)
  (begin (eq! (shift preprocessing/WCP_FLAG k) 1)
         (eq! (shift preprocessing/WCP_INST k) ISZERO)
         (eq! (shift preprocessing/WCP_ARG_1_HI k) a)
         (eq! (shift preprocessing/WCP_ARG_1_LO k) b)
         (debug (vanishes! (shift preprocessing/WCP_ARG_2_HI k)))
         (debug (vanishes! (shift preprocessing/WCP_ARG_2_LO k)))))

;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;    4 EXP_LOG       ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;    4.2 Shorthands  ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun (exponent_hi)
  [macro-instruction/DATA 1])

(defun (exponent_lo)
  [macro-instruction/DATA 2])

(defun (dyn_cost)
  [macro-instruction/DATA 5])

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      ;;
;;    4.3 Preprocessing ;;
;;                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1
(defconstraint preprocessing-1-exp-log (:perspective macro-instruction :guard IS_EXP_LOG)
  (callToISZERO 1 0 (exponent_hi)))

(defun (expn_hi_is_0)
  (shift preprocessing/WCP_RES 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      ;;
;;    4.4 Linking       ;;
;;        constraints   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint linking-constraints-exp-log (:perspective macro-instruction :guard IS_EXP_LOG)
  (begin (eq! (shift computation/PLT_JMP -1) 16)
         (if-not-zero (expn_hi_is_0)
                      (eq! (shift computation/RAW_ACC -1) (exponent_hi)))
         (if-zero (expn_hi_is_0)
                  (eq! (shift computation/RAW_ACC -1) (exponent_lo)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;    4.5 Justify          ;;
;;        hub prediction   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint justify-hub-prediction-exp-log (:perspective macro-instruction :guard IS_EXP_LOG)
  (begin (if-zero (expn_hi_is_0)
                  (eq! (dyn_cost)
                       (* G_EXPBYTES
                          (+ (shift computation/TANZB_ACC -1) 16))))
         (if-not-zero (expn_hi_is_0)
                      (eq! (dyn_cost)
                           (* G_EXPBYTES (shift computation/TANZB_ACC -1))))))

;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;    5 MODEXP_LOG    ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;    5.2 Shorthands  ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun (raw_lead_hi)
  [macro-instruction/DATA 1])

(defun (raw_lead_lo)
  [macro-instruction/DATA 2])

(defun (cds_cutoff)
  [macro-instruction/DATA 3])

(defun (ebs_cutoff)
  [macro-instruction/DATA 4])

(defun (lead_log)
  [macro-instruction/DATA 5])

(defun (trim_acc)
  (shift computation/TRIM_ACC -1))

(defun (used_bytes)
  (shift computation/TANZB_ACC -2))

(defun (used_bits)
  (shift computation/MANZB_ACC -2))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      ;;
;;    5.3 Preprocessing ;;
;;                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1 
(defconstraint preprocessing-1-modexp-log (:perspective macro-instruction :guard IS_MODEXP_LOG)
  (callToLT 1 0 (cds_cutoff) 0 (ebs_cutoff)))

(defun (comp)
  (shift preprocessing/WCP_RES 1))

(defun (min_cutoff)
  (+ (* (cds_cutoff) (comp))
     (* (ebs_cutoff) (- 1 (comp)))))

;; 2
(defconstraint preprocessing-2-modexp-log (:perspective macro-instruction :guard IS_MODEXP_LOG)
  (callToLT 2 0 (min_cutoff) 0 17))

(defun (min_cutoff_leq_16)
  (shift preprocessing/WCP_RES 2))

;; 3
(defconstraint preprocessing-3-modexp-log (:perspective macro-instruction :guard IS_MODEXP_LOG)
  (callToLT 3 0 (ebs_cutoff) 0 17))

(defun (ebs_cutoff_leq_16)
  (shift preprocessing/WCP_RES 3))

;; 4
(defconstraint preprocessing-4-modexp-log (:perspective macro-instruction :guard IS_MODEXP_LOG)
  (callToISZERO 4 0 (raw_lead_hi)))

(defun (raw_hi_part_is_zero)
  (shift preprocessing/WCP_RES 4))

;; 5
(defconstraint preprocessing-5-modexp-log (:perspective macro-instruction :guard IS_MODEXP_LOG)
  (callToISZERO 5 0 (padded_base_2_log)))

(defun (padded_base_2_log)
  (+ (* 8 (used_bytes) (used_bits))))

(defun (trivial_trim)
  (shift preprocessing/WCP_RES 5))



(module oob)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;   2 Constraints     ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;; 2.1 shorthands and  ;;
;;     constants       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (flag_sum_inst)
  (+ IS_JUMP IS_JUMPI IS_RDC IS_CDL IS_XCALL IS_CALL IS_CREATE IS_SSTORE IS_DEPLOYMENT))

(defun (flag_sum_prc_common)
  (+ IS_ECRECOVER IS_SHA2 IS_RIPEMD IS_IDENTITY IS_ECADD IS_ECMUL IS_ECPAIRING))

(defun (flag_sum_prc_blake)
  (+ IS_BLAKE2F_cds IS_BLAKE2F_params))

(defun (flag_sum_prc_modexp)
  (+ IS_MODEXP_cds IS_MODEXP_xbs IS_MODEXP_lead IS_MODEXP_pricing IS_MODEXP_extract))

(defun (flag_sum_prc)
  (+ (flag_sum_prc_common) (flag_sum_prc_blake) (flag_sum_prc_modexp)))

(defun (flag_sum)
  (+ (flag_sum_inst) (flag_sum_prc)))

(defun (wght_sum_inst)
  (+ (* OOB_INST_jump IS_JUMP)
     (* OOB_INST_jumpi IS_JUMPI)
     (* OOB_INST_rdc IS_RDC)
     (* OOB_INST_cdl IS_CDL)
     (* OOB_INST_xcall IS_XCALL)
     (* OOB_INST_call IS_CALL)
     (* OOB_INST_create IS_CREATE)
     (* OOB_INST_sstore IS_SSTORE)
     (* OOB_INST_deployment IS_DEPLOYMENT)))

(defun (wght_sum_prc_common)
  (+ (* OOB_INST_ecrecover IS_ECRECOVER)
     (* OOB_INST_sha2 IS_SHA2)
     (* OOB_INST_ripemd IS_RIPEMD)
     (* OOB_INST_identity IS_IDENTITY)
     (* OOB_INST_ecadd IS_ECADD)
     (* OOB_INST_ecmul IS_ECMUL)
     (* OOB_INST_ecpairing IS_ECPAIRING)))

(defun (wght_sum_prc_blake)
  (+ (* OOB_INST_blake_cds IS_BLAKE2F_cds) (* OOB_INST_blake_params IS_BLAKE2F_params)))

(defun (wght_sum_prc_modexp)
  (+ (* OOB_INST_modexp_cds IS_MODEXP_cds)
     (* OOB_INST_modexp_xbs IS_MODEXP_xbs)
     (* OOB_INST_modexp_lead IS_MODEXP_lead)
     (* OOB_INST_modexp_pricing IS_MODEXP_pricing)
     (* OOB_INST_modexp_extract IS_MODEXP_extract)))

(defun (wght_sum_prc)
  (+ (wght_sum_prc_common) (wght_sum_prc_blake) (wght_sum_prc_modexp)))

(defun (wght_sum)
  (+ (wght_sum_inst) (wght_sum_prc)))

(defun (maxct_sum_inst)
  (+ (* CT_MAX_JUMP IS_JUMP)
     (* CT_MAX_JUMPI IS_JUMPI)
     (* CT_MAX_RDC IS_RDC)
     (* CT_MAX_CDL IS_CDL)
     (* CT_MAX_XCALL IS_XCALL)
     (* CT_MAX_CALL IS_CALL)
     (* CT_MAX_CREATE IS_CREATE)
     (* CT_MAX_SSTORE IS_SSTORE)
     (* CT_MAX_DEPLOYMENT IS_DEPLOYMENT)))

(defun (maxct_sum_prc_common)
  (+ (* CT_MAX_ECRECOVER IS_ECRECOVER)
     (* CT_MAX_SHA2 IS_SHA2)
     (* CT_MAX_RIPEMD IS_RIPEMD)
     (* CT_MAX_IDENTITY IS_IDENTITY)
     (* CT_MAX_ECADD IS_ECADD)
     (* CT_MAX_ECMUL IS_ECMUL)
     (* CT_MAX_ECPAIRING IS_ECPAIRING)))

(defun (maxct_sum_prc_blake)
  (+ (* CT_MAX_BLAKE2F_cds IS_BLAKE2F_cds) (* CT_MAX_BLAKE2F_params IS_BLAKE2F_params)))

(defun (maxct_sum_prc_modexp)
  (+ (* CT_MAX_MODEXP_cds IS_MODEXP_cds)
     (* CT_MAX_MODEXP_xbs IS_MODEXP_xbs)
     (* CT_MAX_MODEXP_lead IS_MODEXP_lead)
     (* CT_MAX_MODEXP_pricing IS_MODEXP_pricing)
     (* CT_MAX_MODEXP_extract IS_MODEXP_extract)))

(defun (maxct_sum_prc)
  (+ (maxct_sum_prc_common) (maxct_sum_prc_blake) (maxct_sum_prc_modexp)))

(defun (maxct_sum)
  (+ (maxct_sum_inst) (maxct_sum_prc)))

(defun (lookup_sum k)
  (+ (shift ADD_FLAG k) (shift MOD_FLAG k) (shift WCP_FLAG k)))

(defun (wght_lookup_sum k)
  (+ (* 1 (shift ADD_FLAG k))
     (* 2 (shift MOD_FLAG k))
     (* 3 (shift WCP_FLAG k))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.2 binary constraints   ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint binary-constraints ()
  (begin (is-binary ADD_FLAG)
         (is-binary MOD_FLAG)
         (is-binary WCP_FLAG)
         (is-binary IS_JUMP)
         (is-binary IS_JUMPI)
         (is-binary IS_RDC)
         (is-binary IS_CDL)
         (is-binary IS_XCALL)
         (is-binary IS_CALL)
         (is-binary IS_CREATE)
         (is-binary IS_SSTORE)
         (is-binary IS_DEPLOYMENT)
         (is-binary IS_ECRECOVER)
         (is-binary IS_SHA2)
         (is-binary IS_RIPEMD)
         (is-binary IS_IDENTITY)
         (is-binary IS_ECADD)
         (is-binary IS_ECMUL)
         (is-binary IS_ECPAIRING)
         (is-binary IS_BLAKE2F_cds)
         (is-binary IS_BLAKE2F_params)
         (is-binary IS_MODEXP_cds)
         (is-binary IS_MODEXP_xbs)
         (is-binary IS_MODEXP_lead)
         (is-binary IS_MODEXP_extract)
         (is-binary IS_MODEXP_pricing)))

;;(for i [2] (is-binary [OOB_EVENT i]))))
(defconstraint wcp-add-mod-are-exclusive ()
  (is-binary (lookup_sum 0)))

;; (defconstraint is-create-is-jump-oob-event ()
;;   (if-zero (+ IS_CREATE IS_JUMPI)
;;            (vanishes! [OOB_EVENT 2])))
;; (defconstraint outgoing-res-lo-binary ()
;;   (if-zero MOD_FLAG
;;            (vanishes! (* OUTGOING_RES_LO (- 1 OUTGOING_RES_LO)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;    2.3 instruction decoding   ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint flag-sum-vanishes ()
  (if-zero STAMP
           (vanishes! (flag_sum))))

(defconstraint flag-sum-equal-one ()
  (if-not-zero STAMP
               (eq! (flag_sum) 1)))

(defconstraint decoding ()
  (eq! OOB_INST (wght_sum)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.4 Constancy            ;;
;;        constraints          ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint counter-constancy ()
  (begin (counter-constancy CT STAMP)
         (debug (counter-constancy CT CT_MAX))
         (for i [8] (counter-constancy CT [DATA i]))
         (counter-constancy CT OOB_INST)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.5 heartbeat    ;;
;;                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint first-row (:domain {0})
  (vanishes! STAMP))

(defconstraint padding-vanishing ()
  (if-zero STAMP
           (begin (vanishes! CT)
                  (vanishes! (+ (lookup_sum 0) (flag_sum))))))

(defconstraint stamp-increments ()
  (any! (remained-constant! STAMP) (did-inc! STAMP 1)))

(defconstraint counter-reset ()
  (if-not-zero (remained-constant! STAMP) ;; if it is false (not zero, in the case of loobean) that STAMP remained constant
               (vanishes! CT)))

(defconstraint ct-max ()
  (eq! CT_MAX (maxct_sum)))

(defconstraint non-trivial-instruction-counter-cycle ()
  (if-not-zero STAMP
               (if-eq-else CT CT_MAX (will-inc! STAMP 1) (will-inc! CT 1))))

(defconstraint final-row (:domain {-1})
  (if-not-zero STAMP
               (eq! CT CT_MAX)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.6 Constraint systems   ;;
;;    for populating lookups   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (callToADD k arg_1_hi arg_1_lo arg_2_hi arg_2_lo)
  (begin (eq! (wght_lookup_sum k) 1)
         (eq! (shift OUTGOING_INST k) ADD)
         (eq! (shift [OUTGOING_DATA 1] k) arg_1_hi)
         (eq! (shift [OUTGOING_DATA 2] k) arg_1_lo)
         (eq! (shift [OUTGOING_DATA 3] k) arg_2_hi)
         (eq! (shift [OUTGOING_DATA 4] k) arg_2_lo)))

(defun (callToDIV k arg_1_hi arg_1_lo arg_2_hi arg_2_lo)
  (begin (eq! (wght_lookup_sum k) 2)
         (eq! (shift OUTGOING_INST k) DIV)
         (eq! (shift [OUTGOING_DATA 1] k) arg_1_hi)
         (eq! (shift [OUTGOING_DATA 2] k) arg_1_lo)
         (eq! (shift [OUTGOING_DATA 3] k) arg_2_hi)
         (eq! (shift [OUTGOING_DATA 4] k) arg_2_lo)))

(defun (callToMOD k arg_1_hi arg_1_lo arg_2_hi arg_2_lo)
  (begin (eq! (wght_lookup_sum k) 2)
         (eq! (shift OUTGOING_INST k) MOD)
         (eq! (shift [OUTGOING_DATA 1] k) arg_1_hi)
         (eq! (shift [OUTGOING_DATA 2] k) arg_1_lo)
         (eq! (shift [OUTGOING_DATA 3] k) arg_2_hi)
         (eq! (shift [OUTGOING_DATA 4] k) arg_2_lo)))

(defun (callToLT k arg_1_hi arg_1_lo arg_2_hi arg_2_lo)
  (begin (eq! (wght_lookup_sum k) 3)
         (eq! (shift OUTGOING_INST k) LT)
         (eq! (shift [OUTGOING_DATA 1] k) arg_1_hi)
         (eq! (shift [OUTGOING_DATA 2] k) arg_1_lo)
         (eq! (shift [OUTGOING_DATA 3] k) arg_2_hi)
         (eq! (shift [OUTGOING_DATA 4] k) arg_2_lo)))

(defun (callToGT k arg_1_hi arg_1_lo arg_2_hi arg_2_lo)
  (begin (eq! (wght_lookup_sum k) 3)
         (eq! (shift OUTGOING_INST k) GT)
         (eq! (shift [OUTGOING_DATA 1] k) arg_1_hi)
         (eq! (shift [OUTGOING_DATA 2] k) arg_1_lo)
         (eq! (shift [OUTGOING_DATA 3] k) arg_2_hi)
         (eq! (shift [OUTGOING_DATA 4] k) arg_2_lo)))

(defun (callToISZERO k arg_1_hi arg_1_lo)
  (begin (eq! (wght_lookup_sum k) 3)
         (eq! (shift OUTGOING_INST k) ISZERO)
         (eq! (shift [OUTGOING_DATA 1] k) arg_1_hi)
         (eq! (shift [OUTGOING_DATA 2] k) arg_1_lo)
         (debug (vanishes! (shift [OUTGOING_DATA 3] k)))
         (debug (vanishes! (shift [OUTGOING_DATA 4] k)))))

(defun (callToEQ k arg_1_hi arg_1_lo arg_2_hi arg_2_lo)
  (begin (eq! (wght_lookup_sum k) 3)
         (eq! (shift OUTGOING_INST k) EQ)
         (eq! (shift [OUTGOING_DATA 1] k) arg_1_hi)
         (eq! (shift [OUTGOING_DATA 2] k) arg_1_lo)
         (eq! (shift [OUTGOING_DATA 3] k) arg_2_hi)
         (eq! (shift [OUTGOING_DATA 4] k) arg_2_lo)))

(defun (noCall k)
  (begin (eq! (wght_lookup_sum k) 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ;;
;;  3 Populating opcodes     ;;
;;                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (standing-hypothesis)
  (- STAMP (prev STAMP)))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;;    3.2 For JUMP       ;;
;; ;;                       ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun (jump-hypothesis)
;;   IS_JUMP)
;; (defun (jump___pc_new_hi)
;;   [DATA 1])
;; (defun (jump___pc_new_lo)
;;   [DATA 2])
;; (defun (jump___codesize)
;;   [DATA 5])
;; (defun (jump___invalid_pc_new)
;;   (- 1 OUTGOING_RES_LO))
;; (defconstraint valid-jump (:guard (* (standing-hypothesis) (jump-hypothesis)))
;;   (callToLT 0 (jump___pc_new_hi) (jump___pc_new_lo) 0 (jump___codesize)))
;; ;; (defconstraint set-oob-event-jump (:guard (* (standing-hypothesis) (jump-hypothesis)))
;; ;;   (begin (eq! [OOB_EVENT 1] (jump___invalid_pc_new))
;; ;;          (vanishes! [OOB_EVENT 2])))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;;    3.3 For JUMPI      ;;
;; ;;                       ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun (jumpi-hypothesis)
;;   IS_JUMPI)
;; (defun (jumpi___pc_new_hi)
;;   [DATA 1])
;; (defun (jumpi___pc_new_lo)
;;   [DATA 2])
;; (defun (jumpi___jump_condition_hi)
;;   [DATA 3])
;; (defun (jumpi___jump_condition_lo)
;;   [DATA 4])
;; (defun (jumpi___codesize)
;;   [DATA 5])
;; (defun (jumpi___invalid_pc_new)
;;   (- 1 OUTGOING_RES_LO))
;; (defun (jumpi___attempt_jump)
;;   (- 1 (next OUTGOING_RES_LO)))
;; (defconstraint valid-jumpi (:guard (* (standing-hypothesis) (jumpi-hypothesis)))
;;   (callToLT 0 (jumpi___pc_new_hi) (jumpi___pc_new_lo) 0 (jumpi___codesize)))
;; (defconstraint valid-jumpi-future (:guard (* (standing-hypothesis) (jumpi-hypothesis)))
;;   (callToISZERO 1 (jumpi___jump_condition_hi) (jumpi___jump_condition_lo)))
;; ;; (defconstraint set-oob-event-jumpi (:guard (* (standing-hypothesis) (jumpi-hypothesis)))
;; ;;   (begin (eq! [OOB_EVENT 1] (* (jumpi___attempt_jump) (jumpi___invalid_pc_new)))
;; ;;          (eq! [OOB_EVENT 2] (jumpi___attempt_jump))))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;; 3.4 For               ;;
;; ;; RETURNDATACOPY        ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun (rdc-hypothesis)
;;   IS_RDC)
;; (defun (rdc___offset_hi)
;;   [DATA 1])
;; (defun (rdc___offset_lo)
;;   [DATA 2])
;; (defun (rdc___size_hi)
;;   [DATA 3])
;; (defun (rdc___size_lo)
;;   [DATA 4])
;; (defun (rdc___rds)
;;   [DATA 5])
;; (defun (rdc___rdc_roob)
;;   (- 1 OUTGOING_RES_LO))
;; (defun (rdc___rdc_soob)
;;   (shift OUTGOING_RES_LO 2))
;; (defconstraint valid-rdc (:guard (* (standing-hypothesis) (rdc-hypothesis)))
;;   (callToISZERO 0 (rdc___offset_hi) (rdc___size_hi)))
;; (defconstraint valid-rdc-future (:guard (* (standing-hypothesis) (rdc-hypothesis)))
;;   (if-zero (rdc___rdc_roob)
;;            (callToADD 1 0 (rdc___offset_lo) 0 (rdc___size_lo))
;;            (noCall 1)))
;; (defconstraint valid-rdc-future-future (:guard (* (standing-hypothesis) (rdc-hypothesis)))
;;   (if-zero (rdc___rdc_roob)
;;            (begin (vanishes! (shift ADD_FLAG 2))
;;                   (vanishes! (shift MOD_FLAG 2))
;;                   (eq! (shift WCP_FLAG 2) 1)
;;                   (eq! (shift OUTGOING_INST 2) GT)
;;                   (vanishes! (shift [OUTGOING_DATA 3] 2))
;;                   (eq! (shift [OUTGOING_DATA 4] 2) (rdc___rds)))
;;            (noCall 2)))
;; ;; (defconstraint set-oob-event-rdc (:guard (* (standing-hypothesis) (rdc-hypothesis)))
;; ;;   (begin (eq! [OOB_EVENT 1]
;; ;;               (+ (rdc___rdc_roob)
;; ;;                  (* (- 1 (rdc___rdc_roob)) (rdc___rdc_soob))))
;; ;;          (vanishes! [OOB_EVENT 2])))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;; 3.5 For               ;;
;; ;; CALLDATALOAD          ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun (cdl-hypothesis)
;;   IS_CDL)
;; (defun (cdl___offset_hi)
;;   [DATA 1])
;; (defun (cdl___offset_lo)
;;   [DATA 2])
;; (defun (cdl___cds)
;;   [DATA 5])
;; (defun (cdl___touches_ram)
;;   OUTGOING_RES_LO)
;; (defconstraint valid-cdl (:guard (* (standing-hypothesis) (cdl-hypothesis)))
;;   (callToLT 0 (cdl___offset_hi) (cdl___offset_lo) 0 (cdl___cds)))
;; ;; (defconstraint set-oob-event-cdl (:guard (* (standing-hypothesis) (cdl-hypothesis)))
;; ;;   (begin (eq! [OOB_EVENT 1] (- 1 (cdl___touches_ram)))
;; ;;          (vanishes! [OOB_EVENT 2])))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;;    3.6 For XCALL's    ;;
;; ;;                       ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun (xcall-hypothesis)
;;   IS_XCALL)
;; (defun (xcall___val_hi)
;;   [DATA 1])
;; (defun (xcall___val_lo)
;;   [DATA 2])
;; (defun (xcall___nonzero_value)
;;   [DATA 4])
;; (defun (xcall___value_ISZERO)
;;   OUTGOING_RES_LO)
;; (defconstraint valid-xcall (:guard (* (standing-hypothesis) (xcall-hypothesis)))
;;   (callToISZERO 0 (xcall___val_hi) (xcall___val_lo)))
;; (defconstraint val-xcall-prediction (:guard (* (standing-hypothesis) (xcall-hypothesis)))
;;   (eq! (xcall___nonzero_value) (- 1 (xcall___value_ISZERO))))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;;    3.7 For CALL's     ;;
;; ;;                       ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun (call-hypothesis)
;;   IS_CALL)
;; (defun (call___val_hi)
;;   [DATA 1])
;; (defun (call___val_lo)
;;   [DATA 2])
;; (defun (call___bal)
;;   [DATA 3])
;; (defun (call___nonzero_value)
;;   [DATA 4])
;; (defun (call___csd)
;;   [DATA 6])
;; (defun (call___insufficient_balance_abort)
;;   OUTGOING_RES_LO)
;; (defun (call___call_stack_depth_abort)
;;   (- 1 (next OUTGOING_RES_LO)))
;; (defun (call___value_ISZERO)
;;   (shift OUTGOING_RES_LO 2))
;; (defconstraint justify-hub-predictions-call (:guard (* (standing-hypothesis) (call-hypothesis)))
;;   (eq! (call___nonzero_value) (- 1 (call___value_ISZERO))))
;; (defconstraint valid-call (:guard (* (standing-hypothesis) (call-hypothesis)))
;;   (callToLT 0 0 (call___bal) (call___val_hi) (call___val_lo)))
;; (defconstraint valid-call-future (:guard (* (standing-hypothesis) (call-hypothesis)))
;;   (callToLT 1 0 (call___csd) 0 1024))
;; (defconstraint valid-call-future-future (:guard (* (standing-hypothesis) (call-hypothesis)))
;;   (callToISZERO 2 (call___val_hi) (call___val_lo)))
;; ;; (defconstraint set-oob-event-call (:guard (* (standing-hypothesis) (call-hypothesis)))
;; ;;   (begin (eq! [OOB_EVENT 1]
;; ;;               (+ (call___insufficient_balance_abort)
;; ;;                  (* (- 1 (call___insufficient_balance_abort)) (call___call_stack_depth_abort))))
;; ;;          (vanishes! [OOB_EVENT 2])))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;; 3.8 For               ;;
;; ;; CREATE's              ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun (create-hypothesis)
;;   IS_CREATE)
;; (defun (create___val_hi)
;;   [DATA 1])
;; (defun (create___val_lo)
;;   [DATA 2])
;; (defun (create___bal)
;;   [DATA 3])
;; (defun (create___nonce)
;;   [DATA 4])
;; (defun (create___has_code)
;;   [DATA 5])
;; (defun (create___csd)
;;   [DATA 6])
;; (defun (create___insufficient_balance_abort)
;;   OUTGOING_RES_LO)
;; (defun (create___stack_depth_abort)
;;   (- 1 (next OUTGOING_RES_LO)))
;; (defun (create___nonzero_nonce)
;;   (- 1 (shift OUTGOING_RES_LO 2)))
;; (defconstraint valid-create (:guard (* (standing-hypothesis) (create-hypothesis)))
;;   (callToLT 0 0 (create___bal) (create___val_hi) (create___val_lo)))
;; (defconstraint valid-create-future (:guard (* (standing-hypothesis) (create-hypothesis)))
;;   (callToLT 1 0 (create___csd) 0 1024))
;; (defconstraint valid-create-future-future (:guard (* (standing-hypothesis) (create-hypothesis)))
;;   (callToISZERO 2 0 (create___nonce)))
;; ;; (defconstraint set-oob-event-create (:guard (* (standing-hypothesis) (create-hypothesis)))
;; ;;   (begin (eq! [OOB_EVENT 1]
;; ;;               (+ (create___insufficient_balance_abort)
;; ;;                  (* (- 1 (create___insufficient_balance_abort)) (create___stack_depth_abort))))
;; ;;          (eq! [OOB_EVENT 2]
;; ;;               (* (- 1 [OOB_EVENT 1])
;; ;;                  (+ (create___has_code)
;; ;;                     (* (- 1 (create___has_code)) (create___nonzero_nonce)))))))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;; 3.9 For               ;;
;; ;; SSTORE                ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun (sstore-hypothesis)
;;   IS_SSTORE)
;; (defun (sstore___gas)
;;   [DATA 5])
;; (defun (sstore___sufficient_gas)
;;   OUTGOING_RES_LO)
;; (defconstraint valid-sstore (:guard (* (standing-hypothesis) (sstore-hypothesis)))
;;   (callToLT 0 0 G_CALLSTIPEND 0 (sstore___gas)))
;; ;; (defconstraint set-oob-event-sstore (:guard (* (standing-hypothesis) (sstore-hypothesis)))
;; ;;   (begin (eq! [OOB_EVENT 1] (- 1 (sstore___sufficient_gas)))
;; ;;          (vanishes! [OOB_EVENT 2])))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;                       ;;
;; ;; 3.10 For              ;;
;; ;; RETURN                ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun (return-hypothesis)
;;   IS_DEPLOYMENT)
;; (defun (return___size_hi)
;;   [DATA 1])
;; (defun (return___size_lo)
;;   [DATA 2])
;; (defun (return___exceeds_max_code_size)
;;   OUTGOING_RES_LO)
;; (defconstraint valid-return (:guard (* (standing-hypothesis) (return-hypothesis)))
;;   (callToLT 0 0 24576 (return___size_hi) (return___size_lo)))
;; ;; (defconstraint set-oob-event-return (:guard (* (standing-hypothesis) (return-hypothesis)))
;; ;;   (begin (eq! [OOB_EVENT 1] (return___exceeds_max_code_size))
;; ;;          (vanishes! [OOB_EVENT 2])))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;   5 Populating common         ;;
;;   precompiles                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 5.1 Common            ;;
;; constraints for       ;; 
;; precompiles           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-hypothesis)
  (flag_sum_prc))

(defun (prc-common-hypothesis)
  (flag_sum_prc_common))

(defun (prc___call_gas)
  [DATA 1])

(defun (prc___cds)
  [DATA 2])

(defun (prc___r_at_c)
  [DATA 3])

(defun (prc___hub_success)
  [DATA 4])

(defun (prc___ram_success)
  [DATA 4])

(defun (prc___return_gas)
  [DATA 5])

(defun (prc___extract_call_data)
  [DATA 6])

(defun (prc___empty_call_data)
  [DATA 7])

(defun (prc___r_at_c_nonzero)
  [DATA 8])

;;
(defun (prc___cds_is_zero)
  OUTGOING_RES_LO)

(defun (prc___r_at_c_is_zero)
  (next OUTGOING_RES_LO))

(defconstraint valid-prc (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-common-hypothesis)))
  (callToISZERO 0 0 (prc___cds)))

(defconstraint valid-prc-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-common-hypothesis)))
  (callToISZERO 1 0 (prc___r_at_c)))

(defconstraint justify-hub-predictions-prc (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-common-hypothesis)))
  (begin (eq! (prc___extract_call_data)
              (* (prc___hub_success) (- 1 (prc___cds_is_zero))))
         (eq! (prc___empty_call_data) (* (prc___hub_success) (prc___cds_is_zero)))
         (eq! (prc___r_at_c_nonzero) (- 1 (prc___r_at_c_is_zero)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 5.2 For ECRECOVER,    ;;
;; ECADD, ECMUL          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-ecrecover-prc-ecadd-prc-ecmul-hypothesis)
  (+ IS_ECRECOVER IS_ECADD IS_ECMUL))

(defun (prc-ecrecover-prc-ecadd-prc-ecmul___precompile_cost)
  (+ (* 3000 IS_ECRECOVER) (* 150 IS_ECADD) (* 6000 IS_ECMUL)))

(defun (prc-ecrecover-prc-ecadd-prc-ecmul___insufficient_gas)
  (shift OUTGOING_RES_LO 2))

(defconstraint valid-prc-ecrecover-prc-ecadd-prc-ecmul-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecrecover-prc-ecadd-prc-ecmul-hypothesis)))
  (callToLT 2 0 (prc___call_gas) 0 (prc-ecrecover-prc-ecadd-prc-ecmul___precompile_cost)))

(defconstraint justify-hub-predictions-prc-ecrecover-prc-ecadd-prc-ecmul (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecrecover-prc-ecadd-prc-ecmul-hypothesis)))
  (begin (eq! (prc___hub_success) (- 1 (prc-ecrecover-prc-ecadd-prc-ecmul___insufficient_gas)))
         (if-zero (prc___hub_success)
                  (vanishes! (prc___return_gas))
                  (eq! (prc___return_gas)
                       (- (prc___call_gas) (prc-ecrecover-prc-ecadd-prc-ecmul___precompile_cost))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 5.3 For SHA2-256,     ;;
;; RIPEMD-160, IDENTITY  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-sha2-prc-ripemd-prc-identity-hypothesis)
  (+ IS_SHA2 IS_RIPEMD IS_IDENTITY))

(defun (prc-sha2-prc-ripemd-prc-identity___ceil)
  (shift OUTGOING_RES_LO 2))

(defun (prc-sha2-prc-ripemd-prc-identity___insufficient_gas)
  (shift OUTGOING_RES_LO 3))

(defun (prc-sha2-prc-ripemd-prc-identity___precompile_cost)
  (* (+ 5 (prc-sha2-prc-ripemd-prc-identity___ceil))
     (+ (* 12 IS_SHA2) (* 120 IS_RIPEMD) (* 3 IS_IDENTITY))))

(defconstraint valid-prc-sha2-prc-ripemd-prc-identity-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-sha2-prc-ripemd-prc-identity-hypothesis)))
  (callToDIV 2 0 (+ (prc___cds) 31) 0 32))

(defconstraint valid-prc-sha2-prc-ripemd-prc-identity-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-sha2-prc-ripemd-prc-identity-hypothesis)))
  (callToLT 3 0 (prc___call_gas) 0 (prc-sha2-prc-ripemd-prc-identity___precompile_cost)))

(defconstraint justify-hub-predictions-prc-sha2-prc-ripemd-prc-identity (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-sha2-prc-ripemd-prc-identity-hypothesis)))
  (begin (eq! (prc___hub_success) (- 1 (prc-sha2-prc-ripemd-prc-identity___insufficient_gas)))
         (if-zero (prc___hub_success)
                  (vanishes! (prc___return_gas))
                  (eq! (prc___return_gas)
                       (- (prc___call_gas) (prc-sha2-prc-ripemd-prc-identity___precompile_cost))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 4.4 For ECPAIRING     ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-ecpairing-hypothesis)
  IS_ECPAIRING)

(defun (prc-ecpairing___remainder)
  (shift OUTGOING_RES_LO 2))

(defun (prc-ecpairing___is_multiple_192)
  (shift OUTGOING_RES_LO 3))

(defun (prc-ecpairing___insufficient_gas)
  (shift OUTGOING_RES_LO 4))

(defun (prc-ecpairing___precompile_cost192)
  (* (prc-ecpairing___is_multiple_192)
     (+ (* 45000 192) (* 34000 (prc___cds)))))

(defconstraint valid-prc-ecpairing-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecpairing-hypothesis)))
  (callToMOD 2 0 (prc___cds) 0 192))

(defconstraint valid-prc-ecpairing-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecpairing-hypothesis)))
  (callToISZERO 3 0 (prc-ecpairing___remainder)))

(defconstraint valid-prc-ecpairing-future-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecpairing-hypothesis)))
  (if-zero (prc-ecpairing___is_multiple_192)
           (noCall 4)
           (begin (vanishes! (shift ADD_FLAG 4))
                  (vanishes! (shift MOD_FLAG 4))
                  (eq! (shift WCP_FLAG 4) 1)
                  (eq! (shift OUTGOING_INST 4) LT)
                  (vanishes! (shift [OUTGOING_DATA 1] 4))
                  (eq! (shift [OUTGOING_DATA 2] 4) (prc___call_gas))
                  (vanishes! (shift [OUTGOING_DATA 3] 4))
                  (eq! (* (shift [OUTGOING_DATA 4] 4) 192)
                       (prc-ecpairing___precompile_cost192)))))

(defconstraint justify-hub-predictions-prc-ecpairing (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecpairing-hypothesis)))
  (begin (eq! (prc___hub_success)
              (* (prc-ecpairing___is_multiple_192) (- 1 (prc-ecpairing___insufficient_gas))))
         (if-zero (prc___hub_success)
                  (vanishes! (prc___return_gas))
                  (eq! (* (prc___return_gas) 192)
                       (- (* (prc___call_gas) 192) (prc-ecpairing___precompile_cost192))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6 Populating MODEXP   ;;
;;   precompiles           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6.1 For MODEXP - cds  ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-modexp_cds-hypothesis)
  IS_MODEXP_cds)

(defun (prc-modexp_cds___extract_bbs)
  [DATA 3])

(defun (prc-modexp_cds___extract_ebs)
  [DATA 4])

(defun (prc-modexp_cds___extract_mbs)
  [DATA 5])

(defconstraint valid-prc-modexp_cds (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_cds-hypothesis)))
  (callToLT 0 0 0 0 (prc___cds)))

(defconstraint valid-prc-modexp_cds-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_cds-hypothesis)))
  (callToLT 1 0 32 0 (prc___cds)))

(defconstraint valid-prc-modexp_cds-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_cds-hypothesis)))
  (callToLT 2 0 64 0 (prc___cds)))

(defconstraint justify-hub-predictions-prc-modexp_cds (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_cds-hypothesis)))
  (begin (eq! (prc-modexp_cds___extract_bbs) OUTGOING_RES_LO)
         (eq! (prc-modexp_cds___extract_ebs) (next OUTGOING_RES_LO))
         (eq! (prc-modexp_cds___extract_mbs) (shift OUTGOING_RES_LO 2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6.2 For MODEXP - xbs  ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-modexp_xbs-hypothesis)
  IS_MODEXP_xbs)

(defun (prc-modexp_xbs___xbs_hi)
  [DATA 1])

(defun (prc-modexp_xbs___xbs_lo)
  [DATA 2])

(defun (prc-modexp_xbs___ybs_lo)
  [DATA 3])

(defun (prc-modexp_xbs___compute_max)
  [DATA 4])

(defun (prc-modexp_xbs___max_xbs_ybs)
  [DATA 7])

(defun (prc-modexp_xbs___xbs_nonzero)
  [DATA 8])

(defun (prc-modexp_xbs___compo_to_512)
  OUTGOING_RES_LO)

(defun (prc-modexp_xbs___comp)
  (next OUTGOING_RES_LO))

(defconstraint valid-prc-modexp_xbs (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_xbs-hypothesis)))
  (callToLT 0 (prc-modexp_xbs___xbs_hi) (prc-modexp_xbs___xbs_lo) 0 513))

(defconstraint valid-prc-modexp_xbs-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_xbs-hypothesis)))
  (callToLT 1 0 (prc-modexp_xbs___xbs_lo) 0 (prc-modexp_xbs___ybs_lo)))

(defconstraint valid-prc-modexp_xbs-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_xbs-hypothesis)))
  (callToISZERO 2 0 (prc-modexp_xbs___xbs_lo)))

(defconstraint additional-prc-modexp_xbs (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_xbs-hypothesis)))
  (begin (vanishes! (* (prc-modexp_xbs___compute_max) (- 1 (prc-modexp_xbs___compute_max))))
         (eq! (prc-modexp_xbs___compo_to_512) 1)))

(defconstraint justify-hub-predictions-prc-modexp_xbs (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_xbs-hypothesis)))
  (if-zero (prc-modexp_xbs___compute_max)
           (begin (vanishes! (prc-modexp_xbs___max_xbs_ybs))
                  (vanishes! (prc-modexp_xbs___xbs_nonzero)))
           (begin (eq! (prc-modexp_xbs___xbs_nonzero)
                       (- 1 (shift OUTGOING_RES_LO 2)))
                  (if-zero (prc-modexp_xbs___comp)
                           (eq! (prc-modexp_xbs___max_xbs_ybs) (prc-modexp_xbs___xbs_lo))
                           (eq! (prc-modexp_xbs___max_xbs_ybs) (prc-modexp_xbs___ybs_lo))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6.3 For MODEXP        ;;
;;   - lead                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-modexp_lead-hypothesis)
  IS_MODEXP_lead)

(defun (prc-modexp_lead___bbs)
  [DATA 1])

(defun (prc-modexp_lead___ebs)
  [DATA 3])

(defun (prc-modexp_lead___load_lead)
  [DATA 4])

(defun (prc-modexp_lead___cds_cutoff)
  [DATA 6])

(defun (prc-modexp_lead___ebs_cutoff)
  [DATA 7])

(defun (prc-modexp_lead___sub_ebs_32)
  [DATA 8])

(defun (prc-modexp_lead___ebs_is_zero)
  OUTGOING_RES_LO)

(defun (prc-modexp_lead___ebs_less_than_32)
  (next OUTGOING_RES_LO))

(defun (prc-modexp_lead___call_data_contains_exponent_bytes)
  (shift OUTGOING_RES_LO 2))

(defun (prc-modexp_lead___comp)
  (shift OUTGOING_RES_LO 3))

(defconstraint valid-prc-modexp_lead (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_lead-hypothesis)))
  (callToISZERO 0 0 (prc-modexp_lead___ebs)))

(defconstraint valid-prc-modexp_lead-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_lead-hypothesis)))
  (callToLT 1 0 (prc-modexp_lead___ebs) 0 32))

(defconstraint valid-prc-modexp_lead-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_lead-hypothesis)))
  (callToLT 2 0 (+ 96 (prc-modexp_lead___ebs)) 0 (prc___cds)))

(defconstraint valid-prc-modexp_lead-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_lead-hypothesis)))
  (callToLT 3
            0
            (- (prc___cds) (+ 96 (prc-modexp_lead___ebs)))
            0
            32))

(defconstraint justify-hub-predictions-prc-modexp_lead (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_lead-hypothesis)))
  (begin (eq! (prc-modexp_lead___load_lead)
              (* (prc-modexp_lead___call_data_contains_exponent_bytes)
                 (- 1 (prc-modexp_lead___ebs_is_zero))))
         (if-zero (prc-modexp_lead___call_data_contains_exponent_bytes)
                  (vanishes! (prc-modexp_lead___cds_cutoff))
                  (if-zero (prc-modexp_lead___comp)
                           (eq! (prc-modexp_lead___cds_cutoff) 32)
                           (eq! (prc-modexp_lead___cds_cutoff)
                                (- (prc___cds) (+ 96 (prc-modexp_lead___bbs))))))
         (if-zero (prc-modexp_lead___ebs_less_than_32)
                  (eq! (prc-modexp_lead___ebs_cutoff) 32)
                  (eq! (prc-modexp_lead___ebs_cutoff) (prc-modexp_lead___ebs)))
         (if-zero (prc-modexp_lead___ebs_less_than_32)
                  (eq! (prc-modexp_lead___sub_ebs_32) (- (prc-modexp_lead___ebs) 32))
                  (vanishes! (prc-modexp_lead___sub_ebs_32)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6.4 For MODEXP        ;;
;;   - pricing             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-modexp_pricing-hypothesis)
  IS_MODEXP_pricing)

(defun (prc-modexp_pricing___exponent_log)
  [DATA 6])

(defun (prc-modexp_pricing___max_xbs_ybs)
  [DATA 7])

(defun (prc-modexp_pricing___exponent_log_is_zero)
  (next OUTGOING_RES_LO))

(defun (prc-modexp_pricing___f_of_max)
  (shift OUTGOING_RES_LO 2))

(defun (prc-modexp_pricing___big_quotient)
  (shift OUTGOING_RES_LO 3))

(defun (prc-modexp_pricing___big_quotient_LT_200)
  (shift OUTGOING_RES_LO 4))

(defun (prc-modexp_pricing___big_numerator)
  (if-zero (prc-modexp_pricing___exponent_log_is_zero)
           (* (prc-modexp_pricing___f_of_max) (prc-modexp_pricing___exponent_log))
           (prc-modexp_pricing___f_of_max)))

(defun (prc-modexp_pricing___precompile_cost)
  (if-zero (prc-modexp_pricing___big_quotient_LT_200)
           (prc-modexp_pricing___big_quotient)
           200))

(defconstraint valid-prc-modexp_pricing (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_pricing-hypothesis)))
  (callToISZERO 0 0 (prc___r_at_c)))

(defconstraint valid-prc-modexp_pricing-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_pricing-hypothesis)))
  (callToISZERO 1 0 (prc-modexp_pricing___exponent_log)))

(defconstraint valid-prc-modexp_pricing-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_pricing-hypothesis)))
  (callToDIV 2
             0
             (+ (* (prc-modexp_pricing___max_xbs_ybs) (prc-modexp_pricing___max_xbs_ybs)) 7)
             0
             8))

(defconstraint valid-prc-modexp_pricing-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_pricing-hypothesis)))
  (callToDIV 3 0 (prc-modexp_pricing___big_numerator) 0 G_QUADDIVISOR))

(defconstraint valid-prc-modexp_pricing-future-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_pricing-hypothesis)))
  (callToLT 4 0 (prc-modexp_pricing___big_quotient) 0 200))

(defconstraint valid-prc-modexp_pricing-future-future-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_pricing-hypothesis)))
  (callToLT 5 0 (prc___call_gas) 0 (prc-modexp_pricing___precompile_cost)))

(defconstraint justify-hub-predictions-prc-modexp_pricing (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_pricing-hypothesis)))
  (begin (eq! (prc___ram_success)
              (- 1 (shift OUTGOING_RES_LO 5)))
         (if-zero (prc___ram_success)
                  (vanishes! (prc___return_gas))
                  (eq! (prc___return_gas) (- (prc___call_gas) (prc-modexp_pricing___precompile_cost))))
         (eq! (prc___r_at_c_nonzero) (- 1 OUTGOING_RES_LO))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6.5 For MODEXP        ;;
;;   - extract             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-modexp_extract-hypothesis)
  IS_MODEXP_extract)

(defun (prc-modexp_extract___bbs)
  [DATA 3])

(defun (prc-modexp_extract___ebs)
  [DATA 4])

(defun (prc-modexp_extract___mbs)
  [DATA 5])

(defun (prc-modexp_extract___extract_base)
  [DATA 6])

(defun (prc-modexp_extract___extract_exponent)
  [DATA 7])

(defun (prc-modexp_extract___extract_modulus)
  [DATA 8])

(defun (prc-modexp_extract___bbs_is_zero)
  OUTGOING_RES_LO)

(defun (prc-modexp_extract___ebs_is_zero)
  (next OUTGOING_RES_LO))

(defun (prc-modexp_extract___mbs_is_zero)
  (shift OUTGOING_RES_LO 2))

(defun (prc-modexp_extract___call_data_extends_beyond_exponent)
  (shift OUTGOING_RES_LO 3))

(defconstraint valid-prc-modexp_extract (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_extract-hypothesis)))
  (callToISZERO 0 0 (prc-modexp_extract___bbs)))

(defconstraint valid-prc-modexp_extract-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_extract-hypothesis)))
  (callToISZERO 1 0 (prc-modexp_extract___ebs)))

(defconstraint valid-prc-modexp_extract-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_extract-hypothesis)))
  (callToISZERO 2 0 (prc-modexp_extract___mbs)))

(defconstraint justify-hub-predictions-prc-modexp_extract (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_extract-hypothesis)))
  (begin (eq! (prc-modexp_extract___extract_modulus)
              (* (prc-modexp_extract___call_data_extends_beyond_exponent)
                 (- 1 (prc-modexp_extract___mbs_is_zero))))
         (eq! (prc-modexp_extract___extract_base)
              (* (prc-modexp_extract___extract_modulus) (- 1 (prc-modexp_extract___bbs_is_zero))))
         (eq! (prc-modexp_extract___extract_exponent)
              (* (prc-modexp_extract___extract_modulus) (- 1 (prc-modexp_extract___ebs_is_zero))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   7 Populating BLAKE2F  ;;
;;   precompiles           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 7.1 For BLAKE2F_cds   ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-blake_cds-hypothesis)
  IS_BLAKE2F_cds)

(defun (prc-blake_cds___valid_cds)
  OUTGOING_RES_LO)

(defun (prc-blake_cds___r_at_c_is_zero)
  (next OUTGOING_RES_LO))

(defconstraint valid-prc-blake_cds (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake_cds-hypothesis)))
  (callToEQ 0 0 (prc___cds) 0 213))

(defconstraint valid-prc-blake_cds-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake_cds-hypothesis)))
  (callToISZERO 1 0 (prc-blake_cds___r_at_c_is_zero)))

(defconstraint justify-hub-predictions-blake2f_a (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake_cds-hypothesis)))
  (begin (eq! (prc___hub_success) (prc-blake_cds___valid_cds))
         (eq! (prc___r_at_c_nonzero) (- 1 (prc-blake_cds___r_at_c_is_zero)))))

;;;;;;;;;;;;;;;;;;;;;;;;;::;;
;;                         ;;
;; 7.2 For BLAKE2F_params  ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-blake_params-hypothesis)
  IS_BLAKE2F_params)

(defun (prc-blake_params___blake_r)
  [DATA 6])

(defun (prc-blake_params___blake_f)
  [DATA 7])

(defun (prc-blake_params___sufficient_gas)
  (- 1 OUTGOING_RES_LO))

(defun (prc-blake_params___f_is_a_bit)
  (next OUTGOING_RES_LO))

(defconstraint valid-prc-blake_params (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake_params-hypothesis)))
  (callToLT 0 0 (prc___call_gas) 0 (prc-blake_params___blake_r)))

(defconstraint valid-prc-blake_params-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake_params-hypothesis)))
  (callToEQ 1
            0
            (prc-blake_params___blake_f)
            0
            (* (prc-blake_params___blake_f) (prc-blake_params___blake_f))))

(defconstraint valid-prc-blake_params-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake_params-hypothesis)))
  (callToISZERO 2 0 (prc___r_at_c)))

(defconstraint justify-hub-predictions-prc-blake_params (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake_params-hypothesis)))
  (begin (eq! (prc___ram_success)
              (* (prc-blake_params___sufficient_gas) (prc-blake_params___f_is_a_bit)))
         (if-not-zero (prc___ram_success)
                      (eq! (prc___return_gas) (- (prc___call_gas) (prc-blake_params___blake_f)))
                      (vanishes! (prc___return_gas)))))



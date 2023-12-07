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
(defconst 
  C_JUMP                     0x56
  C_JUMPI                    0x57
  C_RDC                      0x3E
  C_CDL                      0x35
  C_XCALL                    0xCC
  C_CALL                     0xCA
  C_CREATE                   0xCE
  C_SSTORE                   0x55
  C_RETURN                   0xF3
  C_PRC_ECRECOVER            0xFF01
  C_PRC_SHA2                 0xFF02
  C_PRC_RIPEMD               0xFF03
  C_PRC_IDENTITY             0xFF04
  C_PRC_ECADD                0xFF06
  C_PRC_ECMUL                0xFF07
  C_PRC_ECPAIRING            0xFF08
  C_PRC_BLAKE2F_a            0xFA09
  C_PRC_BLAKE2F_b            0xFB09
  C_PRC_MODEXP_CDS           0xFA05
  C_PRC_MODEXP_BASE          0xFB05
  C_PRC_MODEXP_EXPONENT      0xFC05
  C_PRC_MODEXP_MODULUS       0xFD05
  C_PRC_MODEXP_PRICING       0xFE05
  CT_MAX_JUMP                0
  CT_MAX_JUMPI               1
  CT_MAX_RDC                 2
  CT_MAX_CDL                 0
  CT_MAX_XCALL               0
  CT_MAX_CALL                2
  CT_MAX_CREATE              2
  CT_MAX_SSTORE              0
  CT_MAX_RETURN              0
  CT_MAX_PRC_ECRECOVER       2
  CT_MAX_PRC_SHA2            3
  CT_MAX_PRC_RIPEMD          3
  CT_MAX_PRC_IDENTITY        3
  CT_MAX_PRC_ECADD           2
  CT_MAX_PRC_ECMUL           2
  CT_MAX_PRC_ECPAIRING       4
  CT_MAX_PRC_BLAKE2F_a       0
  CT_MAX_PRC_BLAKE2F_b       2
  CT_MAX_PRC_MODEXP_CDS      3
  CT_MAX_PRC_MODEXP_BASE     3
  CT_MAX_PRC_MODEXP_EXPONENT 2
  CT_MAX_PRC_MODEXP_MODULUS  2
  CT_MAX_PRC_MODEXP_PRICING  5
  LT                         0x10
  ISZERO                     0x15
  ADD                        0x01
  DIV                        0x04
  MOD                        0x06
  GT                         0x11
  EQ                         0x14
  G_CALLSTIPEND              2300)

(defun (flag_sum_inst)
  (+ IS_JUMP IS_JUMPI IS_RDC IS_CDL IS_XCALL IS_CALL IS_CREATE IS_SSTORE IS_RETURN))

(defun (flag_sum_prc_common)
  (+ PRC_ECRECOVER PRC_SHA2 PRC_RIPEMD PRC_IDENTITY PRC_ECADD PRC_ECMUL PRC_ECPAIRING))

(defun (flag_sum_prc_blake)
  (+ PRC_BLAKE2F_a PRC_BLAKE2F_b))

(defun (flag_sum_prc_modexp)
  (+ PRC_MODEXP_CDS PRC_MODEXP_BASE PRC_MODEXP_EXPONENT PRC_MODEXP_MODULUS PRC_MODEXP_PRICING))

(defun (flag_sum_prc)
  (+ (flag_sum_prc_common) (flag_sum_prc_blake) (flag_sum_prc_modexp)))

(defun (flag_sum)
  (+ (flag_sum_inst) (flag_sum_prc)))

(defun (wght_sum_inst)
  (+ (* C_JUMP IS_JUMP)
     (* C_JUMPI IS_JUMPI)
     (* C_RDC IS_RDC)
     (* C_CDL IS_CDL)
     (* C_XCALL IS_XCALL)
     (* C_CALL IS_CALL)
     (* C_CREATE IS_CREATE)
     (* C_SSTORE IS_SSTORE)
     (* C_RETURN IS_RETURN)))

(defun (wght_sum_prc_common)
  (+ (* C_PRC_ECRECOVER PRC_ECRECOVER)
     (* C_PRC_SHA2 PRC_SHA2)
     (* C_PRC_RIPEMD PRC_RIPEMD)
     (* C_PRC_IDENTITY PRC_IDENTITY)
     (* C_PRC_ECADD PRC_ECADD)
     (* C_PRC_ECMUL PRC_ECMUL)
     (* C_PRC_ECPAIRING PRC_ECPAIRING)))

(defun (wght_sum_prc_blake)
  (+ (* C_PRC_BLAKE2F_a PRC_BLAKE2F_a) (* C_PRC_BLAKE2F_b PRC_BLAKE2F_b)))

(defun (wght_sum_prc_modexp)
  (+ (* C_PRC_MODEXP_CDS PRC_MODEXP_CDS)
     (* C_PRC_MODEXP_BASE PRC_MODEXP_BASE)
     (* C_PRC_MODEXP_EXPONENT PRC_MODEXP_EXPONENT)
     (* C_PRC_MODEXP_MODULUS PRC_MODEXP_MODULUS)
     (* C_PRC_MODEXP_PRICING PRC_MODEXP_PRICING)))

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
     (* CT_MAX_RETURN IS_RETURN)))

(defun (maxct_sum_prc_common)
  (+ (* CT_MAX_PRC_ECRECOVER PRC_ECRECOVER)
     (* CT_MAX_PRC_SHA2 PRC_SHA2)
     (* CT_MAX_PRC_RIPEMD PRC_RIPEMD)
     (* CT_MAX_PRC_IDENTITY PRC_IDENTITY)
     (* CT_MAX_PRC_ECADD PRC_ECADD)
     (* CT_MAX_PRC_ECMUL PRC_ECMUL)
     (* CT_MAX_PRC_ECPAIRING PRC_ECPAIRING)))

(defun (maxct_sum_prc_blake)
  (+ (* CT_MAX_PRC_BLAKE2F_a PRC_BLAKE2F_a) (* CT_MAX_PRC_BLAKE2F_b PRC_BLAKE2F_b)))

(defun (maxct_sum_prc_modexp)
  (+ (* CT_MAX_PRC_MODEXP_CDS PRC_MODEXP_CDS)
     (* CT_MAX_PRC_MODEXP_BASE PRC_MODEXP_BASE)
     (* CT_MAX_PRC_MODEXP_EXPONENT PRC_MODEXP_EXPONENT)
     (* CT_MAX_PRC_MODEXP_MODULUS PRC_MODEXP_MODULUS)
     (* CT_MAX_PRC_MODEXP_PRICING PRC_MODEXP_PRICING)))

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

;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     ;;
;;    2.2 heartbeat    ;;
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
  (if-not-zero (remained-constant! STAMP)
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
;;    2.3 counter constancy    ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint counter-constancy ()
  (begin (counter-constancy CT STAMP)
         (debug (counter-constancy CT CT_MAX))
         (for i [2] (counter-constancy CT [OOB_EVENT i]))
         (for i [6] (counter-constancy CT [INCOMING_DATA i]))
         (counter-constancy CT INCOMING_INST)
         (debug (counter-constancy CT IS_JUMP))
         (debug (counter-constancy CT IS_JUMPI))
         (debug (counter-constancy CT IS_RDC))
         (debug (counter-constancy CT IS_CDL))
         (debug (counter-constancy CT IS_CALL))
         (debug (counter-constancy CT IS_CREATE))
         (debug (counter-constancy CT IS_SSTORE))
         (debug (counter-constancy CT IS_RETURN))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                             ;;
;;    2.4 binary constraints   ;;
;;                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These constraints will be auto-generated due to the type of the columns
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
         (is-binary IS_RETURN)
         (is-binary PRC_ECRECOVER)
         (is-binary PRC_SHA2)
         (is-binary PRC_RIPEMD)
         (is-binary PRC_IDENTITY)
         (is-binary PRC_ECADD)
         (is-binary PRC_ECMUL)
         (is-binary PRC_ECPAIRING)
         (is-binary PRC_BLAKE2F_a)
         (is-binary PRC_BLAKE2F_b)
         (is-binary PRC_MODEXP_CDS)
         (is-binary PRC_MODEXP_BASE)
         (is-binary PRC_MODEXP_EXPONENT)
         (is-binary PRC_MODEXP_MODULUS)
         (is-binary PRC_MODEXP_PRICING)
         (for i [2] (is-binary [OOB_EVENT i]))))

(defconstraint wcp-add-mod-are-exclusive ()
  (is-binary (lookup_sum 0)))

(defconstraint is-create-is-jump-oob-event ()
  (if-zero (+ IS_CREATE IS_JUMPI)
           (vanishes! [OOB_EVENT 2])))

(defconstraint outgoing-res-lo-binary ()
  (if-zero MOD_FLAG
           (vanishes! (* OUTGOING_RES_LO (- 1 OUTGOING_RES_LO)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;    2.5 instruction decoding   ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconstraint flag-sum-vanishes ()
  (if-zero STAMP
           (vanishes! (flag_sum))))

(defconstraint flag-sum-equal-one ()
  (if-not-zero STAMP
               (eq! (flag_sum) 1)))

(defconstraint decoding ()
  (eq! INCOMING_INST (wght_sum)))

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

(defun (callToISZERO k arg_1_hi arg_1_lo)
  (begin (eq! (wght_lookup_sum k) 3)
         (eq! (shift OUTGOING_INST k) ISZERO)
         (eq! (shift [OUTGOING_DATA 1] k) arg_1_hi)
         (eq! (shift [OUTGOING_DATA 2] k) arg_1_lo)
         (vanishes! (shift [OUTGOING_DATA 3] k))
         (vanishes! (shift [OUTGOING_DATA 4] k))))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.2 For JUMP       ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (jump-hypothesis)
  IS_JUMP)

(defun (jump___pc_new_hi)
  [INCOMING_DATA 1])

(defun (jump___pc_new_lo)
  [INCOMING_DATA 2])

(defun (jump___codesize)
  [INCOMING_DATA 5])

(defun (jump___invalid_pc_new)
  (- 1 OUTGOING_RES_LO))

(defconstraint valid-jump (:guard (* (standing-hypothesis) (jump-hypothesis)))
  (callToLT 0 (jump___pc_new_hi) (jump___pc_new_lo) 0 (jump___codesize)))

(defconstraint set-oob-event-jump (:guard (* (standing-hypothesis) (jump-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (jump___invalid_pc_new))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.3 For JUMPI      ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (jumpi-hypothesis)
  IS_JUMPI)

(defun (jumpi___pc_new_hi)
  [INCOMING_DATA 1])

(defun (jumpi___pc_new_lo)
  [INCOMING_DATA 2])

(defun (jumpi___jump_condition_hi)
  [INCOMING_DATA 3])

(defun (jumpi___jump_condition_lo)
  [INCOMING_DATA 4])

(defun (jumpi___codesize)
  [INCOMING_DATA 5])

(defun (jumpi___invalid_pc_new)
  (- 1 OUTGOING_RES_LO))

(defun (jumpi___attempt_jump)
  (- 1 (next OUTGOING_RES_LO)))

(defconstraint valid-jumpi (:guard (* (standing-hypothesis) (jumpi-hypothesis)))
  (callToLT 0 (jumpi___pc_new_hi) (jumpi___pc_new_lo) 0 (jumpi___codesize)))

(defconstraint valid-jumpi-future (:guard (* (standing-hypothesis) (jumpi-hypothesis)))
  (callToISZERO 1 (jumpi___jump_condition_hi) (jumpi___jump_condition_lo)))

(defconstraint set-oob-event-jumpi (:guard (* (standing-hypothesis) (jumpi-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (* (jumpi___attempt_jump) (jumpi___invalid_pc_new)))
         (eq! [OOB_EVENT 2] (jumpi___attempt_jump))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.4 For               ;;
;; RETURNDATACOPY        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (rdc-hypothesis)
  IS_RDC)

(defun (rdc___offset_hi)
  [INCOMING_DATA 1])

(defun (rdc___offset_lo)
  [INCOMING_DATA 2])

(defun (rdc___size_hi)
  [INCOMING_DATA 3])

(defun (rdc___size_lo)
  [INCOMING_DATA 4])

(defun (rdc___rds)
  [INCOMING_DATA 5])

(defun (rdc___rdc_roob)
  (- 1 OUTGOING_RES_LO))

(defun (rdc___rdc_soob)
  (shift OUTGOING_RES_LO 2))

(defconstraint valid-rdc (:guard (* (standing-hypothesis) (rdc-hypothesis)))
  (callToISZERO 0 (rdc___offset_hi) (rdc___size_hi)))

(defconstraint valid-rdc-future (:guard (* (standing-hypothesis) (rdc-hypothesis)))
  (if-zero (rdc___rdc_roob)
           (callToADD 1 0 (rdc___offset_lo) 0 (rdc___size_lo))
           (noCall 1)))

(defconstraint valid-rdc-future-future (:guard (* (standing-hypothesis) (rdc-hypothesis)))
  (if-zero (rdc___rdc_roob)
           (begin (vanishes! (shift ADD_FLAG 2))
                  (vanishes! (shift MOD_FLAG 2))
                  (eq! (shift WCP_FLAG 2) 1)
                  (eq! (shift OUTGOING_INST 2) GT)
                  (vanishes! (shift [OUTGOING_DATA 3] 2))
                  (eq! (shift [OUTGOING_DATA 4] 2) (rdc___rds)))
           (noCall 2)))

(defconstraint set-oob-event-rdc (:guard (* (standing-hypothesis) (rdc-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ (rdc___rdc_roob)
                 (* (- 1 (rdc___rdc_roob)) (rdc___rdc_soob))))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.5 For               ;;
;; CALLDATALOAD          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (cdl-hypothesis)
  IS_CDL)

(defun (cdl___offset_hi)
  [INCOMING_DATA 1])

(defun (cdl___offset_lo)
  [INCOMING_DATA 2])

(defun (cdl___cds)
  [INCOMING_DATA 5])

(defun (cdl___touches_ram)
  OUTGOING_RES_LO)

(defconstraint valid-cdl (:guard (* (standing-hypothesis) (cdl-hypothesis)))
  (callToLT 0 (cdl___offset_hi) (cdl___offset_lo) 0 (cdl___cds)))

(defconstraint set-oob-event-cdl (:guard (* (standing-hypothesis) (cdl-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (- 1 (cdl___touches_ram)))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.6 For XCALL's    ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (xcall-hypothesis)
  IS_XCALL)

(defun (xcall___val_hi)
  [INCOMING_DATA 1])

(defun (xcall___val_lo)
  [INCOMING_DATA 2])

(defun (xcall___nonzero_value)
  [INCOMING_DATA 4])

(defun (xcall___value_is_zero)
  OUTGOING_RES_LO)

(defconstraint valid-xcall (:guard (* (standing-hypothesis) (xcall-hypothesis)))
  (callToISZERO 0 (xcall___val_hi) (xcall___val_lo)))

(defconstraint val-xcall-prediction (:guard (* (standing-hypothesis) (xcall-hypothesis)))
  (eq! (xcall___nonzero_value) (- 1 (xcall___value_is_zero))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    3.7 For CALL's     ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (call-hypothesis)
  IS_CALL)

(defun (call___val_hi)
  [INCOMING_DATA 1])

(defun (call___val_lo)
  [INCOMING_DATA 2])

(defun (call___bal)
  [INCOMING_DATA 3])

(defun (call___nonzero_value)
  [INCOMING_DATA 4])

(defun (call___csd)
  [INCOMING_DATA 6])

(defun (call___insufficient_balance_abort)
  OUTGOING_RES_LO)

(defun (call___call_stack_depth_abort)
  (- 1 (next OUTGOING_RES_LO)))

(defun (call___value_is_zero)
  (shift OUTGOING_RES_LO 2))

(defconstraint valid-call (:guard (* (standing-hypothesis) (call-hypothesis)))
  (callToLT 0 0 (call___bal) (call___val_hi) (call___val_lo)))

(defconstraint valid-call-future (:guard (* (standing-hypothesis) (call-hypothesis)))
  (callToLT 1 0 (call___csd) 0 1024))

(defconstraint valid-call-future-future (:guard (* (standing-hypothesis) (call-hypothesis)))
  (callToISZERO 2 (call___val_hi) (call___val_lo)))

(defconstraint val-call-prediction (:guard (* (standing-hypothesis) (call-hypothesis)))
  (eq! (call___nonzero_value) (- 1 (call___value_is_zero))))

(defconstraint set-oob-event-call (:guard (* (standing-hypothesis) (call-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ (call___insufficient_balance_abort)
                 (* (- 1 (call___insufficient_balance_abort)) (call___call_stack_depth_abort))))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.8 For               ;;
;; CREATE's              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (create-hypothesis)
  IS_CREATE)

(defun (create___val_hi)
  [INCOMING_DATA 1])

(defun (create___val_lo)
  [INCOMING_DATA 2])

(defun (create___bal)
  [INCOMING_DATA 3])

(defun (create___nonce)
  [INCOMING_DATA 4])

(defun (create___has_code)
  [INCOMING_DATA 5])

(defun (create___csd)
  [INCOMING_DATA 6])

(defun (create___insufficient_balance_abort)
  OUTGOING_RES_LO)

(defun (create___stack_depth_abort)
  (- 1 (next OUTGOING_RES_LO)))

(defun (create___nonzero_nonce)
  (- 1 (shift OUTGOING_RES_LO 2)))

(defconstraint valid-create (:guard (* (standing-hypothesis) (create-hypothesis)))
  (callToLT 0 0 (create___bal) (create___val_hi) (create___val_lo)))

(defconstraint valid-create-future (:guard (* (standing-hypothesis) (create-hypothesis)))
  (callToLT 1 0 (create___csd) 0 1024))

(defconstraint valid-create-future-future (:guard (* (standing-hypothesis) (create-hypothesis)))
  (callToISZERO 2 0 (create___nonce)))

(defconstraint set-oob-event-create (:guard (* (standing-hypothesis) (create-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ (create___insufficient_balance_abort)
                 (* (- 1 (create___insufficient_balance_abort)) (create___stack_depth_abort))))
         (eq! [OOB_EVENT 2]
              (* (- 1 [OOB_EVENT 1])
                 (+ (create___has_code)
                    (* (- 1 (create___has_code)) (create___nonzero_nonce)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.9 For               ;;
;; SSTORE                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (sstore-hypothesis)
  IS_SSTORE)

(defun (sstore___gas)
  [INCOMING_DATA 5])

(defun (sstore___sufficient_gas)
  OUTGOING_RES_LO)

(defconstraint valid-sstore (:guard (* (standing-hypothesis) (sstore-hypothesis)))
  (callToLT 0 0 G_CALLSTIPEND 0 (sstore___gas)))

(defconstraint set-oob-event-sstore (:guard (* (standing-hypothesis) (sstore-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (- 1 (sstore___sufficient_gas)))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 3.10 For              ;;
;; RETURN                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (return-hypothesis)
  IS_RETURN)

(defun (return___size_hi)
  [INCOMING_DATA 1])

(defun (return___size_lo)
  [INCOMING_DATA 2])

(defun (return___exceeds_max_code_size)
  OUTGOING_RES_LO)

(defconstraint valid-return (:guard (* (standing-hypothesis) (return-hypothesis)))
  (callToLT 0 0 24576 (return___size_hi) (return___size_lo)))

(defconstraint set-oob-event-return (:guard (* (standing-hypothesis) (return-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (return___exceeds_max_code_size))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;   4 Populating common         ;;
;;   precompiles                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 4.1 Common            ;;
;; constraints for       ;; 
;; precompiles           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-hypothesis)
  (flag_sum_prc))

(defun (prc-common-hypothesis)
  (flag_sum_prc_common))

(defun (prc___call_gas)
  [INCOMING_DATA 1])

(defun (prc___remaining_gas)
  [INCOMING_DATA 2])

(defun (prc___cds)
  [INCOMING_DATA 3])

(defun (prc___cds_is_zero)
  [INCOMING_DATA 4])

(defun (prc___r_at_c)
  [INCOMING_DATA 5])

(defun (prc___r_at_c_is_zero)
  [INCOMING_DATA 6])

(defconstraint valid-prc (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-common-hypothesis)))
  (begin (callToISZERO 0 0 (prc___cds))
         (eq! OUTGOING_RES_LO (prc___cds_is_zero))))

(defconstraint valid-prc-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-common-hypothesis)))
  (begin (callToISZERO 1 0 (prc___r_at_c))
         (eq! (next OUTGOING_RES_LO) (prc___r_at_c_is_zero))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 4.2 For ECRECOVER,    ;;
;; ECADD, ECMUL          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-ecrecover-prc-ecadd-prc-ecmul-hypothesis)
  (+ PRC_ECRECOVER PRC_ECADD PRC_ECMUL))

(defun (prc-ecrecover-prc-ecadd-prc-ecmul___precompile_cost)
  (+ (* 3000 PRC_ECRECOVER) (* 150 PRC_ECADD) (* 6000 PRC_ECMUL)))

(defconstraint valid-prc-ecrecover-prc-ecadd-prc-ecmul-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecrecover-prc-ecadd-prc-ecmul-hypothesis)))
  (callToLT 2 0 (prc___call_gas) 0 (prc-ecrecover-prc-ecadd-prc-ecmul___precompile_cost)))

(defconstraint set-oob-event-prc-ecrecover-prc-ecadd-prc-ecmul (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecrecover-prc-ecadd-prc-ecmul-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (shift OUTGOING_RES_LO 2))
         (vanishes! [OOB_EVENT 2])))

(defconstraint constrain-remaining-gas-prc-ecrecover-prc-ecadd-prc-ecmul (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecrecover-prc-ecadd-prc-ecmul-hypothesis)))
  (if-zero [OOB_EVENT 1]
           (eq! (prc___remaining_gas)
                (- (prc___call_gas) (prc-ecrecover-prc-ecadd-prc-ecmul___precompile_cost)))
           (vanishes! (prc___remaining_gas))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 4.3 For SHA2-256,     ;;
;; RIPEMD-160, IDENTITY  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-sha2-prc-ripemd-prc-identity-hypothesis)
  (+ PRC_SHA2 PRC_RIPEMD PRC_IDENTITY))

(defun (prc-sha2-prc-ripemd-prc-identity___ceil)
  (shift OUTGOING_RES_LO 2))

(defun (prc-sha2-prc-ripemd-prc-identity___precompile_cost)
  (* (+ 5 (prc-sha2-prc-ripemd-prc-identity___ceil))
     (+ (* 12 PRC_SHA2) (* 120 PRC_RIPEMD) (* 3 PRC_IDENTITY))))

(defconstraint valid-prc-sha2-prc-ripemd-prc-identity-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-sha2-prc-ripemd-prc-identity-hypothesis)))
  (callToDIV 2 0 (+ (prc___cds) 31) 0 32))

(defconstraint valid-prc-sha2-prc-ripemd-prc-identity-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-sha2-prc-ripemd-prc-identity-hypothesis)))
  (callToLT 3 0 (prc___call_gas) 0 (prc-sha2-prc-ripemd-prc-identity___precompile_cost)))

(defconstraint set-oob-event-prc-sha2-prc-ripemd-prc-identity (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-sha2-prc-ripemd-prc-identity-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (shift OUTGOING_RES_LO 3))
         (vanishes! [OOB_EVENT 2])))

(defconstraint constrain-remaining-gas-prc-sha2-prc-ripemd-prc-identity (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-sha2-prc-ripemd-prc-identity-hypothesis)))
  (if-zero [OOB_EVENT 1]
           (eq! (prc___remaining_gas)
                (- (prc___call_gas) (prc-sha2-prc-ripemd-prc-identity___precompile_cost)))
           (vanishes! (prc___remaining_gas))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 4.4 For ECPAIRING     ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-ecpairing-hypothesis)
  PRC_ECPAIRING)

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

(defconstraint set-oob-event-prc-ecpairing (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecpairing-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ (- 1 (prc-ecpairing___is_multiple_192))
                 (* (prc-ecpairing___is_multiple_192) (prc-ecpairing___insufficient_gas))))
         (vanishes! [OOB_EVENT 2])))

(defconstraint constrain-remaining-gas-prc-ecpairing (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-ecpairing-hypothesis)))
  (if-zero [OOB_EVENT 1]
           (eq! (* (prc___remaining_gas) 192)
                (- (* (prc___call_gas) 192) (prc-ecpairing___precompile_cost192)))
           (vanishes! (prc___remaining_gas))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   5 Populating BLAKE2F  ;;
;;   precompiles           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 5.1 For BLAKE2F_a     ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-blake2f_a-hypothesis)
  PRC_BLAKE2F_a)

(defun (prc-blake2f_a___cds)
  [INCOMING_DATA 3])

(defun (prc-blake2f_a___valid_cds)
  OUTGOING_RES_LO)

;; TODO: double check if the second line is required
(defconstraint valid-prc-blake2f_a (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake2f_a-hypothesis)))
  (begin (callToEQ 0 0 (prc-blake2f_a___cds) 0 213)
         (eq! OUTGOING_RES_LO (prc___cds_is_zero))))

(defconstraint set-oob-event-blake2f_a (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake2f_a-hypothesis)))
  (begin (eq! [OOB_EVENT 1] (- 1 (prc-blake2f_a___valid_cds)))
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 5.2 For BLAKE2F_b    ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-blake2f_b-hypothesis)
  PRC_BLAKE2F_b)

(defun (prc-blake2f_b___call_gas)
  [INCOMING_DATA 1])

(defun (prc-blake2f_b___remaining_gas)
  [INCOMING_DATA 2])

(defun (prc-blake2f_b___blake_r)
  [INCOMING_DATA 3])

(defun (prc-blake2f_b___blake_f)
  [INCOMING_DATA 4])

(defun (prc-blake2f_b___r_at_c)
  [INCOMING_DATA 5])

(defun (prc-blake2f_b___r_at_c_is_zero)
  [INCOMING_DATA 6])

(defun (prc-blake2f_b___insufficient_gas)
  OUTGOING_RES_LO)

(defun (prc-blake2f_b___f_is_not_a_bit)
  (- 1 (next OUTGOING_RES_LO)))

(defconstraint valid-prc-blake2f_b (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake2f_b-hypothesis)))
  (callToLT 0 0 (prc-blake2f_b___call_gas) 0 (prc-blake2f_b___blake_r)))

(defconstraint valid-prc-blake2f_b-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake2f_b-hypothesis)))
  (callToEQ 1 0 (prc-blake2f_b___blake_f) 0 (* (prc-blake2f_b___blake_f) (prc-blake2f_b___blake_f))))

(defconstraint valid-prc-blake2f_b-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake2f_b-hypothesis)))
  (begin (callToISZERO 2 0 (prc-blake2f_b___r_at_c))
         (eq! (shift OUTGOING_RES_LO 2) (prc-blake2f_b___r_at_c_is_zero))))

(defconstraint set-oob-event-prc-blake2f_b (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake2f_b-hypothesis)))
  (begin (eq! [OOB_EVENT 1]
              (+ (prc-blake2f_b___insufficient_gas)
                 (* (- 1 (prc-blake2f_b___insufficient_gas)) (prc-blake2f_b___f_is_not_a_bit))))
         (vanishes! [OOB_EVENT 2])))

(defconstraint constrain-remaining-gas-prc-blake2f_b (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-blake2f_b-hypothesis)))
  (if-zero [OOB_EVENT 1]
           (eq! (prc-blake2f_b___remaining_gas)
                (- (prc-blake2f_b___call_gas) (prc-blake2f_b___remaining_gas)))
           (vanishes! (prc-blake2f_b___remaining_gas))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6 Populating MODEXP   ;;
;;   precompiles           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO make justify-hub-predictions consistent with specs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6.1 For MODEXP - CDS  ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-modexp_cds-hypothesis)
  PRC_MODEXP_CDS)

(defun (prc-modexp_cds___cds)
  [INCOMING_DATA 2])

(defun (prc-modexp_cds___cds_is_zero)
  [INCOMING_DATA 3])

(defun (prc-modexp_cds___cds_leq_32)
  [INCOMING_DATA 4])

(defun (prc-modexp_cds___cds_leq_64)
  [INCOMING_DATA 5])

(defun (prc-modexp_cds___cds_leq_96)
  [INCOMING_DATA 6])

(defconstraint valid-prc-modexp_cds (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_cds-hypothesis)))
  (begin (callToISZERO 0 0 (prc-modexp_cds___cds))
         (eq! OUTGOING_RES_LO (prc-modexp_cds___cds_is_zero))))

(defconstraint valid-prc-modexp_cds-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_cds-hypothesis)))
  (begin (callToLT 1 0 (prc-modexp_cds___cds) 0 33)
         (eq! (next OUTGOING_RES_LO) (prc-modexp_cds___cds_leq_32))))

(defconstraint valid-prc-modexp_cds-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_cds-hypothesis)))
  (begin (callToLT 2 0 (prc-modexp_cds___cds) 0 65)
         (eq! (shift OUTGOING_RES_LO 2) (prc-modexp_cds___cds_leq_64))))

(defconstraint valid-prc-modexp_cds-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_cds-hypothesis)))
  (begin (callToLT 3 0 (prc-modexp_cds___cds) 0 97)
         (eq! (shift OUTGOING_RES_LO 3) (prc-modexp_cds___cds_leq_96))))

(defconstraint set-oob-event-prc-modexp_cds (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_cds-hypothesis)))
  (begin (vanishes! [OOB_EVENT 1])
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6.2 For MODEXP - base ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-modexp_base-hypothesis)
  PRC_MODEXP_BASE)

(defun (prc-modexp_base___cds)
  [INCOMING_DATA 1])

(defun (prc-modexp_base___bbs)
  [INCOMING_DATA 2])

(defun (prc-modexp_base___bbs_is_zero)
  [INCOMING_DATA 3])

(defun (prc-modexp_base___call_data_extends_beyond_base)
  [INCOMING_DATA 4])

(defun (prc-modexp_base___by_less_than_an_EVM_word)
  [INCOMING_DATA 5])

(defun (prc-modexp_base___compo_to_512)
  OUTGOING_RES_LO)

(defconstraint valid-prc-modexp_base (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_base-hypothesis)))
  (begin (callToLT 0 0 (prc-modexp_base___bbs) 0 513)
         (eq! 1 (prc-modexp_base___compo_to_512))))

(defconstraint valid-prc-modexp_base-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_base-hypothesis)))
  (begin (callToISZERO 1 0 (prc-modexp_base___bbs))
         (eq! (next OUTGOING_RES_LO) (prc-modexp_base___bbs_is_zero))))

(defconstraint valid-prc-modexp_base-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_base-hypothesis)))
  (begin (callToLT 2 0 (+ 96 (prc-modexp_base___bbs)) 0 (prc-modexp_base___cds))
         (eq! (shift OUTGOING_RES_LO 2) (prc-modexp_base___call_data_extends_beyond_base))))

(defconstraint valid-prc-modexp_base-future-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_base-hypothesis)))
  (begin (callToLT 3
                   0
                   (- (prc-modexp_base___cds) (+ 96 (prc-modexp_base___bbs)))
                   0
                   32)
         (eq! (shift OUTGOING_RES_LO 3) (prc-modexp_base___by_less_than_an_EVM_word))))

(defconstraint set-oob-event-prc-modexp_base (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_base-hypothesis)))
  (begin (vanishes! [OOB_EVENT 1])
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6.3 For MODEXP        ;;
;;   - exponent            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-modexp_exponent-hypothesis)
  PRC_MODEXP_EXPONENT)

(defun (prc-modexp_exponent___ebs)
  [INCOMING_DATA 2])

(defun (prc-modexp_exponent___ebs_is_zero)
  [INCOMING_DATA 3])

(defun (prc-modexp_exponent___ebs_lt_32)
  [INCOMING_DATA 4])

(defun (prc-modexp_exponent___min_ebs_32)
  [INCOMING_DATA 5])

(defun (prc-modexp_exponent___ebs_sub_32)
  [INCOMING_DATA 6])

(defun (prc-modexp_exponent___comp_to_512)
  OUTGOING_RES_LO)

(defconstraint justify-hub-predictions-prc-modexp_exponent (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_exponent-hypothesis)))
  (if-zero (prc-modexp_exponent___ebs_lt_32)
           (begin (eq! (prc-modexp_exponent___min_ebs_32) 32)
                  (eq! (prc-modexp_exponent___ebs_sub_32) (- (prc-modexp_exponent___ebs) 32)))
           (begin (eq! (prc-modexp_exponent___min_ebs_32) (prc-modexp_exponent___ebs))
                  (vanishes! (prc-modexp_exponent___ebs_sub_32)))))

(defconstraint valid-prc-modexp_exponent (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_exponent-hypothesis)))
  (begin (callToLT 0 0 (prc-modexp_exponent___ebs) 0 513)
         (eq! 1 (prc-modexp_exponent___comp_to_512))))

(defconstraint valid-prc-modexp_exponent-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_exponent-hypothesis)))
  (begin (callToISZERO 1 0 (prc-modexp_exponent___ebs))
         (eq! (next OUTGOING_RES_LO) (prc-modexp_exponent___ebs_is_zero))))

(defconstraint valid-prc-modexp_exponent-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_exponent-hypothesis)))
  (begin (callToLT 2 0 (prc-modexp_exponent___ebs) 0 32)
         (eq! (shift OUTGOING_RES_LO 2) (prc-modexp_exponent___ebs_lt_32))))

(defconstraint set-oob-event-prc-modexp_exponent (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_exponent-hypothesis)))
  (begin (vanishes! [OOB_EVENT 1])
         (vanishes! [OOB_EVENT 2])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;   6.4 For MODEXP        ;;
;;   - modulus             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun (prc-modexp_modulus-hypothesis)
  PRC_MODEXP_MODULUS)

(defun (prc-modexp_modulus___bbs)
  [INCOMING_DATA 1])

(defun (prc-modexp_modulus___mbs)
  [INCOMING_DATA 2])

(defun (prc-modexp_modulus___mbs_is_zero)
  [INCOMING_DATA 3])

(defun (prc-modexp_modulus___max_mbs_bbs)
  [INCOMING_DATA 4])

(defun (prc-modexp_modulus___comp_to_512)
  OUTGOING_RES_LO)

(defun (prc-modexp_modulus___mbs_lt_bbs)
  (next OUTGOING_RES_LO))

(defconstraint justify-hub-predictions-prc-modexp_modulus (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_modulus-hypothesis)))
  (if-zero (prc-modexp_modulus___mbs_lt_bbs)
           (begin (eq! (prc-modexp_modulus___max_mbs_bbs) (prc-modexp_modulus___bbs)))
           (begin (eq! (prc-modexp_modulus___max_mbs_bbs) (prc-modexp_modulus___mbs)))))

(defconstraint valid-prc-modexp_modulus (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_modulus-hypothesis)))
  (begin (callToLT 0 0 (prc-modexp_modulus___mbs) 0 513)
         (eq! 1 (prc-modexp_modulus___comp_to_512))))

(defconstraint valid-prc-modexp_modulus-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_modulus-hypothesis)))
  (begin (callToISZERO 1 0 (prc-modexp_modulus___mbs))
         (eq! (next OUTGOING_RES_LO) (prc-modexp_modulus___mbs_is_zero))))

(defconstraint valid-prc-modexp_modulus-future-future (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_modulus-hypothesis)))
  (callToLT 2 0 (prc-modexp_modulus___mbs) 0 (prc-modexp_modulus___bbs)))

(defconstraint set-oob-event-prc-modexp_modulus (:guard (* (standing-hypothesis) (prc-hypothesis) (prc-modexp_modulus-hypothesis)))
  (begin (vanishes! [OOB_EVENT 1])
         (vanishes! [OOB_EVENT 2])))



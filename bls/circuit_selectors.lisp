(module bls)

(defun (cs_G1MT_for_g1_msm)
    (* DATA_G1_MSM_FLAG IS_FIRST_INPUT MEXT_BIT))

(defun (cs_G1MT_for_g2_msm)
    (* DATA_G2_MSM_FLAG IS_FIRST_INPUT MEXT_BIT))

(defun (cs_G1MT_for_pairing_malformed)
    (* DATA_PAIRING_CHECK_FLAG IS_FIRST_INPUT MEXT_BIT))

(defun (cs_G2MT_for_pairing_malformed)
    (* DATA_PAIRING_CHECK_FLAG IS_SECOND_INPUT MEXT_BIT))

(defun (cs_G1MT_for_pairing_wellformed)
    (* DATA_PAIRING_CHECK_FLAG IS_FIRST_INPUT (- 1 NONTRIVIAL_POP_BIT) (- 1 IS_INFINITY) (wellformed_data)))

(defun (cs_G2MT_for_pairing_wellformed)
    (* DATA_PAIRING_CHECK_FLAG IS_SECOND_INPUT (- 1 NONTRIVIAL_POP_BIT) (- 1 IS_INFINITY) (wellformed_data)))  

(defun (is_nontrivial_pairing_data_or_result)
    (+ (* DATA_PAIRING_CHECK_FLAG NONTRIVIAL_POP_BIT) RSLT_PAIRING_CHECK_FLAG))  

(defconstraint set-cs-c1-membership ()
    (eq! CS_G1_MEMBERSHIP (* MEXT_BIT DATA_G1_ADD_FLAG)))

(defconstraint set-cs-c2-membership ()
    (eq! CS_G2_MEMBERSHIP (* MEXT_BIT DATA_G2_MSM_FLAG)))

(defconstraint set-cs-g1-membership ()
    (eq! CS_G1_MEMBERSHIP 
    (+ (cs_G1MT_for_g1_msm)
       (cs_G1MT_for_pairing_malformed)
       (cs_G1MT_for_pairing_wellformed))))

(defconstraint set-cs-g2-membership ()
    (eq! CS_G2_MEMBERSHIP 
    (+ (cs_G1MT_for_g2_msm)
       (cs_G2MT_for_pairing_malformed)
       (cs_G2MT_for_pairing_wellformed))))

(defconstraint set-cs-point-evaluation ()
    (eq! CS_POINT_EVALUATION (* WNON (is_point_evaluation))))

(defconstraint set-cs-g1-add ()
    (eq! CS_G1_ADD (* WNON (is_g1_add))))

(defconstraint set-cs-g1-msm ()
    (eq! CS_G1_MSM (* WNON (is_g1_msm))))

(defconstraint set-cs-g2-msm ()
    (eq! CS_G2_MSM (* WNON (is_g2_msm))))

(defconstraint set-cs-pairing-check ()
    (eq! CS_PAIRING (* WNON (is_nontrivial_pairing_data_or_result))))

(defconstraint set-cs-map-fp-to-g1 ()
    (eq! CS_MAP_FP_TO_G1 (* WNON (is_map_fp_to_g1))))

(defconstraint set-cs-map-fp2-to-g2 ()
    (eq! CS_MAP_FP2_TO_G2 (* WNON (is_map_fp2_to_g2))))
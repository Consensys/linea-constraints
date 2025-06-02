(module bls)

(defun (is_point_evaluation)
    (+ IS_POINT_EVALUATION_DATA IS_POINT_EVALUATION_RESULT))

(defun (is_g1_add)
    (+ IS_G1_ADD_DATA IS_G1_ADD_RESULT))

(defun (is_g1_msm)
    (+ IS_G1_MSM_DATA IS_G1_MSM_RESULT))

(defun (is_g2_add)
    (+ IS_G2_ADD_DATA IS_G2_ADD_RESULT))

(defun (is_g2_msm)
    (+ IS_G2_MSM_DATA IS_G2_MSM_RESULT))

(defun (is_pairing_check)
    (+ IS_PAIRING_CHECK_DATA IS_PAIRING_CHECK_RESULT))

(defun (is_map_fp_to_g1)
    (+ IS_MAP_FP_TO_G1_DATA IS_MAP_FP_TO_G1_RESULT))

(defun (is_map_fp2_to_g2)
    (+ IS_MAP_FP2_TO_G2_DATA IS_MAP_FP2_TO_G2_RESULT))
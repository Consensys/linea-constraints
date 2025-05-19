(module bls)

(defcolumns
  (STAMP        :i32)
  (ID           :i32)
  (INDEX        :i16)
  (LIMB         :i128)
  (TOTAL_SIZE   :i16)
  (PHASE        :i16)
  (INDEX_MAX    :i16)
  (SUCCESS_BIT  :binary@prove)

  (IS_POINT_EVALUATION_DATA    :binary@prove)
  (IS_POINT_EVALUATION_RESULT  :binary@prove)
  (IS_G1_ADD_DATA              :binary@prove)
  (IS_G1_ADD_RESULT            :binary@prove)
  (IS_G1_MSM_DATA              :binary@prove)
  (IS_G1_MSM_RESULT            :binary@prove)
  (IS_G2_ADD_DATA              :binary@prove)
  (IS_G2_ADD_RESULT            :binary@prove)
  (IS_G2_MSM_DATA              :binary@prove)
  (IS_G2_MSM_RESULT            :binary@prove)
  (IS_PAIRING_CHECK_DATA       :binary@prove)
  (IS_PAIRING_CHECK_RESULT     :binary@prove)
  (IS_MAP_FP_TO_G1_DATA        :binary@prove)
  (IS_MAP_FP_TO_G1_RESULT      :binary@prove)
  (IS_MAP_FP2_TO_G2_DATA       :binary@prove)
  (IS_MAP_FP2_TO_G2_RESULT     :binary@prove)

  
  (TOTAL_INPUTS                                  :i16)
  (ACC_INPUTS                                    :i16)
  (INTERNAL_CHECKS_PASSED                        :binary@prove)
  (PARTIAL_CHECKS                                :binary@prove)
  (BYTE_DELTA                                    :byte@prove)
  (CT                                            :i3)
  (CT_MAX                                        :i3)
  (IS_FIRST_INPUT                                :binary@prove)
  (IS_SECOND_INPUT                               :binary@prove)
  (IS_INFINITY                                   :binary@prove)
  (TRIVIAL_ALL_INFTY                             :binary@prove)
  (TRIVIAL_WITH_MEMBERSHIP_CHECK                 :binary@prove)
  (NOT_ON_CX                                     :binary@prove)
  (NOT_ON_CX_ACC                                 :binary@prove)
  (NOT_ON_CX_ACC_MAX                             :binary@prove)
  (NOT_ON_GX                                     :binary@prove)
  (NOT_ON_GX_ACC                                 :binary@prove)
  (NOT_ON_GX_ACC_MAX                             :binary@prove)
  (C1_MEMBERSHIP_TEST_REQUIRED                   :binary@prove)
  (G1_MEMBERSHIP_TEST_REQUIRED                   :binary@prove)
  (C2_MEMBERSHIP_TEST_REQUIRED                   :binary@prove)
  (G2_MEMBERSHIP_TEST_REQUIRED                   :binary@prove)
  (ACCEPTABLE_PAIR_OF_POINTS_FOR_PAIRING_CIRCUIT :binary@prove)

 (CIRCUIT_SELECTOR_POINT_EVALUATION :binary@prove)
 (CIRCUIT_SELECTOR_C1_MEMBERSHIP    :binary@prove)
 (CIRCUIT_SELECTOR_G1_MEMBERSHIP    :binary@prove)
 (CIRCUIT_SELECTOR_C2_MEMBERSHIP    :binary@prove)
 (CIRCUIT_SELECTOR_G2_MEMBERSHIP    :binary@prove)
 (CIRCUIT_SELECTOR_PAIRING          :binary@prove)
 (CIRCUIT_SELECTOR_G1_ADD           :binary@prove)
 (CIRCUIT_SELECTOR_G2_ADD           :binary@prove)
 (CIRCUIT_SELECTOR_G1_MSM           :binary@prove)
 (CIRCUIT_SELECTOR_G2_MSM           :binary@prove)
 (CIRCUIT_SELECTOR_MAP_FP_TO_G1      :binary@prove)
 (CIRCUIT_SELECTOR_MAP_FP2_TO_G2     :binary@prove)

 (WCP_FLAG     :binary@prove)
 (WCP_ARG1_HI  :i128)
 (WCP_ARG1_LO  :i128)
 (WCP_ARG2_HI  :i128)
 (WCP_ARG2_LO  :i128)
 (WCP_RES      :binary)
 (WCP_INST     :byte :display :opcode)
)

;; aliases
(defalias
  ICP                 INTERNAL_CHECKS_PASSED
  PART_CHECKS         PARTIAL_CHECKS
  C1MTR               C1_MEMBERSHIP_TEST_REQUIRED
  G1MTR               G1_MEMBERSHIP_TEST_REQUIRED
  C2MTR               C2_MEMBERSHIP_TEST_REQUIRED
  G2MTR               G2_MEMBERSHIP_TEST_REQUIRED
  ACCPC               ACCEPTABLE_PAIR_OF_POINTS_FOR_PAIRING_CIRCUIT
  CS_POINT_EVALUATION CIRCUIT_SELECTOR_POINT_EVALUATION
  CS_C1_MEMBERSHIP    CIRCUIT_SELECTOR_C1_MEMBERSHIP
  CS_G1_MEMBERSHIP    CIRCUIT_SELECTOR_G1_MEMBERSHIP
  CS_C2_MEMBERSHIP    CIRCUIT_SELECTOR_C2_MEMBERSHIP
  CS_G2_MEMBERSHIP    CIRCUIT_SELECTOR_G2_MEMBERSHIP
  CS_PAIRING          CIRCUIT_SELECTOR_PAIRING
  CS_G1_ADD           CIRCUIT_SELECTOR_G1_ADD
  CS_G2_ADD           CIRCUIT_SELECTOR_G2_ADD
  CS_G1_MSM           CIRCUIT_SELECTOR_G1_MSM
  CS_G2_MSM           CIRCUIT_SELECTOR_G2_MSM
  CS_MAP_FP_TO_G1     CIRCUIT_SELECTOR_MAP_FP_TO_G1
  CS_MAP_FP2_TO_G2    CIRCUIT_SELECTOR_MAP_FP2_TO_G2
)



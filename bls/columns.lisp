(module bls)

(defcolumns
  (STAMP        :i32)
  (ID           :i32)
  (TOTAL_SIZE   :i16)
  (INDEX        :i16)
  (INDEX_MAX    :i16)
  (LIMB         :i128)
  (PHASE        :i16)
  (SUCCESS_BIT  :binary@prove)

  (DATA_POINT_EVALUATION    :binary@prove) ;; TODO: flags?
  (DATA_G1_ADD              :binary@prove)
  (DATA_G1_MSM              :binary@prove)
  (DATA_G2_ADD              :binary@prove)
  (DATA_G2_MSM              :binary@prove)
  (DATA_PAIRING_CHECK       :binary@prove)
  (DATA_MAP_FP_TO_G1        :binary@prove)
  (DATA_MAP_FP2_TO_G2       :binary@prove)
  
  (RSLT_POINT_EVALUATION  :binary@prove)
  (RSLT_G1_ADD            :binary@prove)
  (RSLT_G1_MSM            :binary@prove)
  (RSLT_G2_ADD            :binary@prove)
  (RSLT_G2_MSM            :binary@prove)
  (RSLT_PAIRING_CHECK     :binary@prove)
  (RSLT_MAP_FP_TO_G1      :binary@prove)
  (RSLT_MAP_FP2_TO_G2     :binary@prove)
 
  (ACC_INPUTS                                    :i16)
  (BYTE_DELTA                                    :byte@prove)


  (MALFORMED_DATA_INTERNAL_BIT                    :binary@prove)
  (MALFORMED_DATA_INTERNAL_ACC                    :binary@prove)
  (MALFORMED_DATA_INTERNAL_ACC_TOT                :binary@prove)
  (MALFORMED_DATA_EXTERNAL_BIT                    :binary@prove)
  (MALFORMED_DATA_EXTERNAL_ACC                    :binary@prove)
  (MALFORMED_DATA_EXTERNAL_ACC_TOT                :binary@prove)
  (WELLFORMED_DATA_TRIVIAL                        :binary@prove)
  (WELLFORMED_DATA_NONTRIVIAL                     :binary@prove)

  (IS_FIRST_INPUT                                :binary@prove)
  (IS_SECOND_INPUT                               :binary@prove)
  (IS_INFINITY                                   :binary@prove)
  (NONTRIVIAL_PAIR_OF_POINTS_BIT                 :binary@prove)
  (NONTRIVIAL_PAIR_OF_POINTS_ACC                 :binary@prove)

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
  ;; TODO: add missing
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



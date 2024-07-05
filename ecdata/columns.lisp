(module ecdata)

(defcolumns 
  (STAMP :i32)
  (ID :i32)
  (INDEX :byte)
  (LIMB :i128)
  TOTAL_SIZE
  (PHASE :i16@prove)
  INDEX_MAX
  (SUCCESS_BIT :binary@prove)
  (IS_ECRECOVER_DATA :binary@prove)
  (IS_ECRECOVER_RESULT :binary@prove)
  (IS_ECADD_DATA :binary@prove)
  (IS_ECADD_RESULT :binary@prove)
  (IS_ECMUL_DATA :binary@prove)
  (IS_ECMUL_RESULT :binary@prove)
  (IS_ECPAIRING_DATA :binary@prove)
  (IS_ECPAIRING_RESULT :binary@prove)
  TOTAL_PAIRINGS
  ACC_PAIRINGS
  (INTERNAL_CHECKS_PASSED :binary@prove)
  (HURDLE :binary@prove)
  (BYTE_DELTA :byte@prove)
  (CT :i3@prove)
  (CT_MAX :i3@prove)
  (IS_SMALL_POINT :binary@prove)
  (IS_LARGE_POINT :binary@prove)
  (NOT_ON_G2 :binary@prove)
  (NOT_ON_G2_ACC :binary@prove)
  (NOT_ON_G2_ACC_MAX :binary@prove)
  (IS_INFINITY :binary@prove)
  (OVERALL_TRIVIAL_PAIRING :binary@prove)
  (G2_MEMBERSHIP_TEST_REQUIRED :binary@prove)
  (ACCEPTABLE_PAIR_OF_POINTS_FOR_PAIRING_CIRCUIT :binary@prove)
  (CIRCUIT_SELECTOR_ECRECOVER :binary@prove)
  (CIRCUIT_SELECTOR_ECADD :binary@prove)
  (CIRCUIT_SELECTOR_ECMUL :binary@prove)
  (CIRCUIT_SELECTOR_ECPAIRING :binary@prove)
  (CIRCUIT_SELECTOR_G2_MEMBERSHIP :binary@prove)
  (WCP_FLAG :binary@prove)
  (WCP_ARG1_HI :i128)
  (WCP_ARG1_LO :i128)
  (WCP_ARG2_HI :i128)
  (WCP_ARG2_LO :i128)
  (WCP_RES :binary)
  (WCP_INST :byte :display :opcode)
  (EXT_FLAG :binary@prove)
  (EXT_ARG1_HI :i128)
  (EXT_ARG1_LO :i128)
  (EXT_ARG2_HI :i128)
  (EXT_ARG2_LO :i128)
  (EXT_ARG3_HI :i128)
  (EXT_ARG3_LO :i128)
  (EXT_RES_LO :i128)
  (EXT_RES_HI :i128)
  (EXT_INST :byte :display :opcode))

;; aliases
(defalias 
  ICP              INTERNAL_CHECKS_PASSED
  TRIVIAL_PAIRING  OVERALL_TRIVIAL_PAIRING
  G2MTR            G2_MEMBERSHIP_TEST_REQUIRED
  ACCPC            ACCEPTABLE_PAIR_OF_POINTS_FOR_PAIRING_CIRCUIT
  CS_ECRECOVER     CIRCUIT_SELECTOR_ECRECOVER
  CS_ECADD         CIRCUIT_SELECTOR_ECADD
  CS_ECMUL         CIRCUIT_SELECTOR_ECMUL
  CS_ECPAIRING     CIRCUIT_SELECTOR_ECPAIRING
  CS_G2_MEMBERSHIP CIRCUIT_SELECTOR_G2_MEMBERSHIP)



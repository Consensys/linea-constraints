(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                ;;;;
;;;;    X.Y CALL    ;;;;
;;;;                ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;


(defconst
  ;;
  precompile-processing---ECADD_MUL_PAIRING_and_BLS---misc-row-offset---full-return-data-transfer                   2
  precompile-processing---ECADD_MUL_PAIRING_and_BLS---misc-row-offset---partial-return-data-copy                    3
  precompile-processing---ECADD_MUL_PAIRING_and_BLS---context-row-offset---updating-caller-context                  4
  ;;
  ECADD_RETURN_DATA_SIZE                                                                                  64
  ECMUL_RETURN_DATA_SIZE                                                                                  64
  ECPAIRING_RETURN_DATA_SIZE                                                                              32
  POINT_EVALUATION_RETURN_DATA_SIZE                                                                       64
  BLS_G1_ADD_RETURN_DATA_SIZE                                                                            128
  BLS_G1_MSM_RETURN_DATA_SIZE                                                                            128
  BLS_G2_ADD_RETURN_DATA_SIZE                                                                            256
  BLS_G2_MSM_RETURN_DATA_SIZE                                                                            256
  BLS_PAIRING_CHECK_RETURN_DATA_SIZE                                                                      32
  BLS_MAP_FP_TO_G1_RETURN_DATA_SIZE                                                                      128
  BLS_MAP_FP2_TO_G2_RETURN_DATA_SIZE                                                                     256
  )

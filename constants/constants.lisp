(module constants)

(defconst 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                 ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; EVM INSTRUCTION ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                 ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  LT                                                          16
  EQ_                                                         20
  ISZERO                                                      21
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;               ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SIZE / LENGTH ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;               ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  LLARGEMO                                                    15
  LLARGE                                                      16
  LLARGEPO                                                    (+ LLARGE 1)
  WORD_SIZE                                                   32
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MISC SHARED ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  INVALID_CODE_PREFIX_VALUE                                   0xEF
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MMU MODULE ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;
  ;;MMU Instructions
  ;;
  MMU_INST_MLOAD                                              0xfe01
  MMU_INST_MSTORE                                             0xfe02
  MMU_INST_MSTORE8                                            0x53
  MMU_INST_INVALID_CODE_PREFIX                                0xfe00
  MMU_INST_RIGHT_PADDED_WORD_EXTRACTION                       0xfe10
  MMU_INST_RAM_TO_EXO_WITH_PADDING                            0xfe20
  MMU_INST_EXO_TO_RAM_TRANSPLANTS                             0xfe30
  MMU_INST_RAM_TO_RAM_SANS_PADDING                            0xfe40
  MMU_INST_ANY_TO_RAM_WITH_PADDING                            0xfe50
  MMU_INST_ANY_TO_RAM_WITH_PADDING_SOME_DATA                  0xfe51
  MMU_INST_ANY_TO_RAM_WITH_PADDING_PURE_PADDING               0xfe52
  MMU_INST_MODEXP_ZERO                                        0xfe60
  MMU_INST_MODEXP_DATA                                        0xfe70
  MMU_INST_BLAKE                                              0xfe80
  ;;
  ;; MMU NB OF PP ROWS
  ;;
  MMU_INST_NB_PP_ROWS_MLOAD                                   1
  MMU_INST_NB_PP_ROWS_MSTORE                                  1
  MMU_INST_NB_PP_ROWS_MSTORE8                                 1
  MMU_INST_NB_PP_ROWS_INVALID_CODE_PREFIX                     1
  MMU_INST_NB_PP_ROWS_RIGHT_PADDED_WORD_EXTRACTION            5
  MMU_INST_NB_PP_ROWS_RAM_TO_EXO_WITH_PADDING                 4
  MMU_INST_NB_PP_ROWS_EXO_TO_RAM_TRANSPLANTS                  1
  MMU_INST_NB_PP_ROWS_RAM_TO_RAM_SANS_PADDING                 5
  MMU_INST_NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING    4
  MMU_INST_NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA       1
  MMU_INST_NB_PP_ROWS_MODEXP_ZERO                             1
  MMU_INST_NB_PP_ROWS_MODEXP_DATA                             6
  MMU_INST_NB_PP_ROWS_BLAKE                                   2
  ;;
  ;; MMU NB OF PP ROWS + 1
  ;;
  MMU_INST_NB_PP_ROWS_MLOAD_PO                                (+ MMU_INST_NB_PP_ROWS_MLOAD 1)
  MMU_INST_NB_PP_ROWS_MSTORE_PO                               (+ MMU_INST_NB_PP_ROWS_MSTORE 1)
  MMU_INST_NB_PP_ROWS_MSTORE8_PO                              (+ MMU_INST_NB_PP_ROWS_MSTORE8 1)
  MMU_INST_NB_PP_ROWS_INVALID_CODE_PREFIX_PO                  (+ MMU_INST_NB_PP_ROWS_INVALID_CODE_PREFIX 1)
  MMU_INST_NB_PP_ROWS_RIGHT_PADDED_WORD_EXTRACTION_PO         (+ MMU_INST_NB_PP_ROWS_RIGHT_PADDED_WORD_EXTRACTION 1)
  MMU_INST_NB_PP_ROWS_RAM_TO_EXO_WITH_PADDING_PO              (+ MMU_INST_NB_PP_ROWS_RAM_TO_EXO_WITH_PADDING 1)
  MMU_INST_NB_PP_ROWS_EXO_TO_RAM_TRANSPLANTS_PO               (+ MMU_INST_NB_PP_ROWS_EXO_TO_RAM_TRANSPLANTS 1)
  MMU_INST_NB_PP_ROWS_RAM_TO_RAM_SANS_PADDING_PO              (+ MMU_INST_NB_PP_ROWS_RAM_TO_RAM_SANS_PADDING 1)
  MMU_INST_NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING_PO (+ MMU_INST_NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING 1)
  MMU_INST_NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA_PO    (+ MMU_INST_NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA 1)
  MMU_INST_NB_PP_ROWS_MODEXP_ZERO_PO                          (+ MMU_INST_NB_PP_ROWS_MODEXP_ZERO 1)
  MMU_INST_NB_PP_ROWS_MODEXP_DATA_PO                          (+ MMU_INST_NB_PP_ROWS_MODEXP_DATA 1)
  MMU_INST_NB_PP_ROWS_BLAKE_PO                                (+ MMU_INST_NB_PP_ROWS_BLAKE 1)
  ;;
  ;; MMU NB OF PP ROWS + 2
  ;;
  MMU_INST_NB_PP_ROWS_MLOAD_PT                                (+ MMU_INST_NB_PP_ROWS_MLOAD 2)
  MMU_INST_NB_PP_ROWS_MSTORE_PT                               (+ MMU_INST_NB_PP_ROWS_MSTORE 2)
  MMU_INST_NB_PP_ROWS_RIGHT_PADDED_WORD_EXTRACTION_PT         (+ MMU_INST_NB_PP_ROWS_RIGHT_PADDED_WORD_EXTRACTION 2)
  ;;
  ;; MMU NB OF micro-processing rows
  ;;
  MMU_INST_NB_MICRO_ROWS_TOT_MLOAD                            2
  MMU_INST_NB_MICRO_ROWS_TOT_MSTORE                           2
  MMU_INST_NB_MICRO_ROWS_TOT_MSTORE_EIGHT                     1
  MMU_INST_NB_MICRO_ROWS_TOT_INVALID_CODE_PREFIX              1
  MMU_INST_NB_MICRO_ROWS_TOT_RIGHT_PADDED_WORD_EXTRACTION     2
  ;;MMU_INST_NB_MICRO_ROWS_TOT_RAM_TO_EXO_WITH_PADDING              variable
  ;;MMU_INST_NB_MICRO_ROWS_TOT_EXO_TO_RAM_TANSPLANTS                variable
  ;;MMU_INST_NB_MICRO_ROWS_TOT_RAM_TO_RAM_SANS_PADDING              variable
  ;;MMU_INST_NB_MICRO_ROWS_TOT_ANY_TO_RAM_WITH_PADDING_PURE_PADDING variable
  ;;MMU_INST_NB_MICRO_ROWS_TOT_ANY_TO_RAM_WITH_PADDING_SOME_DATA    variable
  MMU_INST_NB_MICRO_ROWS_TOT_MODEXP_ZERO                      32
  MMU_INST_NB_MICRO_ROWS_TOT_MODEXP_DATA                      32
  MMU_INST_NB_MICRO_ROWS_TOT_BLAKE                            2
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MMIO MODULE ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;
  ;; MMIO Instructions
  ;;
  ;; LIMB
  MMIO_INST_LIMB_VANISHES                                     0xfe01
  ;; LIMB to RAM
  MMIO_INST_LIMB_TO_RAM_TRANSPLANT                            0xfe11
  MMIO_INST_LIMB_TO_RAM_ONE_TARGET                            0xfe12
  MMIO_INST_LIMB_TO_RAM_TWO_TARGET                            0xfe13
  ;; Ram to LIMB
  MMIO_INST_RAM_TO_LIMB_TRANSPLANT                            0xfe21
  MMIO_INST_RAM_TO_LIMB_ONE_SOURCE                            0xfe22
  MMIO_INST_RAM_TO_LIMB_TWO_SOURCE                            0xfe23
  ;; RAM to RAM
  MMIO_INST_RAM_TO_RAM_TRANSPLANT                             0xfe31
  MMIO_INST_RAM_TO_RAM_PARTIAL                                0xfe32
  MMIO_INST_RAM_TO_RAM_TWO_TARGET                             0xfe33
  MMIO_INST_RAM_TO_RAM_TWO_SOURCE                             0xfe34
  ;; RAM
  MMIO_INST_RAM_EXCISION                                      0xfe41
  MMIO_INST_RAM_VANISHES                                      0xfe42)



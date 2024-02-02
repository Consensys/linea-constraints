(module mmu)

(defconst 
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
  MMU_INST_BLAKE_PARAM                                        0xfe80
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
  MMU_INST_NB_PP_ROWS_BLAKE_PARAM                             2
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
  MMU_INST_NB_PP_ROWS_BLAKE_PARAM_PO                          (+ MMU_INST_NB_PP_ROWS_BLAKE_PARAM 1)
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
  MMU_INST_NB_MICRO_ROWS_TOT_BLAKE_PARAM                      2
  ;;
  ;; MMIO Instructions
  ;;
  ;; Exo
  MMIO_INST_EXO_LIMB_VANISHES                                 0xff00
  ;; Ram to Exo
  MMIO_INST_RAM_TO_EXO_LIMB_TRANSPLANT                        0xff10
  MMIO_INST_TWO_RAM_TO_EXO_FULL                               0xff11
  MMIO_INST_PADDED_EXO_FROM_ONE_RAM                           0xff12
  MMIO_INST_PADDED_EXO_FROM_TWO_RAM                           0xff13
  ;;Exo to Ram
  MMIO_INST_EXO_TO_RAM_LIMB_TRANSPLANT                        0xff20
  MMIO_INST_EXO_TO_RAM_SLIDE_CHUNK                            0xff21
  MMIO_INST_EXO_TO_RAM_SLIDE_OVERLAPPING_CHUNK                0xff22
  ;;limbs to RAM
  MMIO_INST_LIMB_TO_RAM_WRITE_LSB                             0xff30
  MMIO_INST_LIMB_TO_RAM_TRANSPLANT                            0xff31
  MMIO_INST_LIMB_TO_RAM_OVERLAP                               0xff32
  ;;RAM to limbs
  MMIO_INST_RAM_TO_LIMB_TRANSPLANT                            0xff40
  MMIO_INST_PADDED_LIMB_FROM_ONE_RAM                          0xff41
  MMIO_INST_PADDED_LIMB_FROM_TWO_RAM                          0xff42
  ;;RAM to RAM
  MMIO_INST_RAM_TO_RAM_LIMB_TRANSPLANT                        0xff50
  MMIO_INST_RAM_TO_RAM_SLIDE_CHUNK                            0xff51
  MMIO_INST_RAM_TO_RAM_SLIDE_OVERLAPPING_CHUNK                0xff52
  ;RAM
  MMIO_INST_RAM_EXCISION                                      0xff60
  MMIO_INST_RAM_LIMB_VANISHES                                 0xff61
  ;;
  ;; Misc constant ;; most of them are doublons
  ;;
  LT                                                          16
  EQ_                                                         20
  ISZERO                                                      21
  LLARGEMO                                                    15
  LLARGE                                                      16
  LLARGEPO                                                    17
  WORD_SIZE                                                   32
  INVALID_CODE_PREFIX_VALUE                                   0xEF)

;; OLD MMIO INST, TO DELETE
;;
;; ;transplants
;; RamToRam                             601
;; ExoToRam                             602
;; RamIsExo                             603
;; KillingOne                           604
;; PushTwoRamToStack                    605
;; PushOneRamToStack                    606
;; ExceptionalRamToStack3To2FullFast    607
;; PushTwoStackToRam                    608
;; StoreXInAThreeRequired               609
;; StoreXInB                            610
;; StoreXInC                            611
;; ;surgeries
;; RamLimbExcision                      613
;; RamToRamSlideChunk                   614
;; RamToRamSlideOverlappingChunk        615
;; ExoToRamSlideChunk                   616
;; ExoToRamSlideOverlappingChunk        618
;; PaddedExoFromOne                     619
;; PaddedExoFromTwo                     620
;; FullExoFromTwo                       621
;; FullStackToRam                       623
;; LsbFromStackToRAM                    624
;; FirstFastSecondPadded                625
;; FirstPaddedSecondZero                626
;; Exceptional_RamToStack_3To2Full      627
;; NA_RamToStack_3To2Full               628
;; NA_RamToStack_3To2Padded             629
;; NA_RamToStack_2To2Padded             630
;; NA_RamToStack_2To1FullAndZero        631
;; NA_RamToStack_2To1PaddedAndZero      632
;; NA_RamToStack_1To1PaddedAndZero      633)



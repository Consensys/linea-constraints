(module mmu)

(defconst 
  ;;
  ;;MMU Instructions
  ;;
  MMU_INST_MLOAD                                           0x51
  MMU_INST_MSTORE                                          0x52
  MMU_INST_MSTORE8                                         0x53
  MMU_INST_INVALID_CODE_PREFIX                             0xfe15
  MMU_INST_RIGHT_PADDED_WORD_EXTRACTION                    0xfe16
  MMU_INST_RAM_TO_EXO_WITH_PADDING                         0xfe17
  MMU_INST_EXO_TO_RAM_TRANSPLANTS                          0xfe18
  MMU_INST_RAM_TO_RAM_SANS_PADDING                         0xfe19
  MMU_INST_ANY_TO_RAM_WITH_PADDING_SOME_DATA               0xfe20
  MMU_INST_ANY_TO_RAM_WITH_PADDING_PURE_PADDING            0xfe21
  MMU_INST_MODEXP_ZERO                                     0xfe22
  MMU_INST_MODEXP_DATA                                     0xfe23
  MMU_INST_BLAKE_PARAM                                     0xfe24
  ;;
  ;; MMIO Instructions
  ;;
  ;; Exo
  MMIO_INST_EXO_LIMB_VANISHES                              0xff00
  ;; Ram to Exo
  MMIO_INST_RAM_TO_EXO_LIMB_TRANSPLANT                     0xff10
  MMIO_INST_TWO_RAM_TO_EXO_FULL                            0xff11
  MMIO_INST_PADDED_EXO_FROM_ONE_RAM                        0xff12
  MMIO_INST_PADDED_EXO_FROM_TWO_RAM                        0xff13
  ;;Exo to Ram
  MMIO_INST_EXO_TO_RAM_LIMB_TRANSPLANT                     0xff20
  MMIO_INST_EXO_TO_RAM_SLIDE_CHUNK                         0xff21
  MMIO_INST_EXO_TO_RAM_SLIDE_OVERLAPPING_CHUNK             0xff22
  ;;limbs to RAM
  MMIO_INST_WRITE_LESAST_SIGNIFICANT_BYTE_TO_RAM           0xff30
  MMIO_INST_WRITE_EVM_WORD_TO_RAM_ALIGNED                  0xff31
  MMIO_INST_WRITE_EVM_WORD_TO_RAM_NON_ALIGNED              0xff32
  ;;RAM to limbs
  MMIO_INST_RAM_TO_LIMB_TRANSPLANT                         0xff40
  MMIO_INST_EXTRACT_EVM_WORD_FROM_RAM_ALIGNED              0xff41
  MMIO_INST_EXTRACT_EVM_WORD_FROM_RAM_NON_ALIGNED          0xff42
  MMIO_INST_PADDED_LIMB_FROM_ONE_RAM                       0xff43
  MMIO_INST_PADDED_LIMB_FROM_TWO_RAM                       0xff44
  ;;RAM to RAM
  MMIO_INST_RAM_TO_RAM_LIMB_TRANSPLANT                     0xff50
  MMIO_INST_RAM_TO_RAM_SLIDE_CHUNK                         0xff51
  MMIO_INST_RAM_TO_RAM_SLIDE_OVERLAPPING_CHUNK             0xff52
  ;RAM
  MMIO_INST_RAM_EXCISION                                   0xff60
  MMIO_INST_RAM_LIMB_VANISHES                              0xff61
  ;;
  ;; MMU NB OF ROWS FOR INSTRUCTION
  ;;
  MMU_INST_NB_PP_ROWS_MLOAD                                1
  MMU_INST_NB_PP_ROWS_MSTORE                               1
  MMU_INST_NB_PP_ROWS_MSTORE_EIGHT                         1
  MMU_INST_NB_PP_ROWS_INVALID_CODE_PREFIX                  1
  MMU_INST_NB_PP_ROWS_RIGHT_PADDED_WORD_EXTRACTION         5
  MMU_INST_NB_PP_ROWS_RAM_TO_EXO_WITH_PADDING              4
  MMU_INST_NB_PP_ROWS_EXO_TO_RAM_TANSPLANTS                1
  MMU_INST_NB_PP_ROWS_RAM_TO_RAM_SANS_PADDING              5
  MMU_INST_NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_PURE_PADDING 4
  MMU_INST_NB_PP_ROWS_ANY_TO_RAM_WITH_PADDING_SOME_DATA    1
  MMU_INST_NB_PP_ROWS_MODEXP_ZERO                          1
  MMU_INST_NB_PP_ROWS_MODEXP_DATA                          6
  MMU_INST_NB_PP_ROWS_BLAKE_PARAM                          2)

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



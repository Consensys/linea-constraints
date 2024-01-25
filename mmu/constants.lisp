(module mmu)

(defconst 
  ;;MMU Instructions
  MLOAD                                0x51
  MSTORE                               0x52
  MSTORE8                              0x53
  INVALID_CODE_PREFIX                  0xff15
  RIGHT_PADDED_WORD_EXTRACTION         0xff16
  RAM_TO_EXO_WITH_PADDING              0xff17
  EXO_TO_RAM_TRANSPLANTS               0xff18
  RAM_TO_RAM_SANS_PADDING              0xff19
  ANY_TO_RAM_WITH_PADDING_SOME_DATA    0xff20
  ANY_TO_RAM_WITH_PADDING_PURE_PADDING 0xff21
  MODEXP_ZERO                          0xff22
  MODEXP_DATA                          0xff23
  BLAKE_PARAM                          0xff24
  ;; MMIO Instructions
  ;transplants
  RamToRam                             601
  ExoToRam                             602
  RamIsExo                             603
  KillingOne                           604
  PushTwoRamToStack                    605
  PushOneRamToStack                    606
  ExceptionalRamToStack3To2FullFast    607
  PushTwoStackToRam                    608
  StoreXInAThreeRequired               609
  StoreXInB                            610
  StoreXInC                            611
  ;surgeries
  RamLimbExcision                      613
  RamToRamSlideChunk                   614
  RamToRamSlideOverlappingChunk        615
  ExoToRamSlideChunk                   616
  ExoToRamSlideOverlappingChunk        618
  PaddedExoFromOne                     619
  PaddedExoFromTwo                     620
  FullExoFromTwo                       621
  FullStackToRam                       623
  LsbFromStackToRAM                    624
  FirstFastSecondPadded                625
  FirstPaddedSecondZero                626
  Exceptional_RamToStack_3To2Full      627
  NA_RamToStack_3To2Full               628
  NA_RamToStack_3To2Padded             629
  NA_RamToStack_2To2Padded             630
  NA_RamToStack_2To1FullAndZero        631
  NA_RamToStack_2To1PaddedAndZero      632
  NA_RamToStack_1To1PaddedAndZero      633)



(defun (op-flag-sum-shan)
  (+ mmioshan.IS_LIMB_VANISHES
     mmioshan.IS_LIMB_TO_RAM_TRANSPLANT
     mmioshan.IS_LIMB_TO_RAM_ONE_TARGET
     mmioshan.IS_LIMB_TO_RAM_TWO_TARGET
     mmioshan.IS_RAM_TO_LIMB_TRANSPLANT
     mmioshan.IS_RAM_TO_LIMB_ONE_SOURCE
     mmioshan.IS_RAM_TO_LIMB_TWO_SOURCE
     mmioshan.IS_RAM_TO_RAM_TRANSPLANT
     mmioshan.IS_RAM_TO_RAM_PARTIAL
     mmioshan.IS_RAM_TO_RAM_TWO_TARGET
     mmioshan.IS_RAM_TO_RAM_TWO_SOURCE
     mmioshan.IS_RAM_EXCISION
     mmioshan.IS_RAM_VANISHES))

(deflookup
  mmio-into-mmu
  ;reference columns
  (
    mmushan.MICRO
    mmushan.MMIO_STAMP
    mmushan.micro/INST
    mmushan.micro/SIZE
    mmushan.micro/SLO
    mmushan.micro/SBO
    mmushan.micro/TLO
    mmushan.micro/TBO
    mmushan.micro/LIMB
    mmushan.micro/CN_S
    mmushan.micro/CN_T
    mmushan.micro/SUCCESS_BIT
    mmushan.micro/EXO_SUM
    mmushan.micro/PHASE
    mmushan.micro/EXO_ID
    mmushan.micro/KEC_ID
    mmushan.micro/TOTAL_SIZE
  )
  ;source columns
  (
    (op-flag-sum-shan)
    mmioshan.MMIO_STAMP
    mmioshan.MMIO_INSTRUCTION
    mmioshan.SIZE
    mmioshan.SLO
    mmioshan.SBO
    mmioshan.TLO
    mmioshan.TBO
    mmioshan.LIMB
    mmioshan.CNS
    mmioshan.CNT
    mmioshan.SUCCESS_BIT
    mmioshan.EXO_SUM
    mmioshan.PHASE
    mmioshan.EXO_ID
    mmioshan.KEC_ID
    mmioshan.TOTAL_SIZE
  ))



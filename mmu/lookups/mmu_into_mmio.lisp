(deflookup 
  mmu-into-mmio
  ;reference columns
  (
    mmio.MMIO_STAMP
    mmio.MMIO_INSTRUCTION
    mmio.SIZE
    mmio.SLO
    mmio.SBO
    mmio.TLO
    mmio.TBO
    mmio.LIMB
    mmio.CNS
    mmio.CNT
    mmio.SUCCESS_BIT
    mmio.EXO_SUM
    mmio.PHASE
    mmio.EXO_ID
    mmio.KEC_ID
    mmio.TOTAL_SIZE
  )
  ;source columns
  (
    (* mmu.MMIO_STAMP mmu.MICRO)
    mmu.micro/INST
    mmu.micro/SIZE
    mmu.micro/SLO
    mmu.micro/SBO
    mmu.micro/TLO
    mmu.micro/TBO
    mmu.micro/LIMB
    mmu.micro/CN_S
    mmu.micro/CN_T
    mmu.micro/SUCCESS_BIT
    mmu.micro/EXO_SUM
    mmu.micro/PHASE
    mmu.micro/EXO_ID
    mmu.micro/KEC_ID
    mmu.micro/TOTAL_SIZE
  ))



(deflookup
  mmio-into-rom
  ;reference columns
  (
    rom.CFI
    rom.INDEX
    rom.LIMB
    rom.CODE_SIZE
  )
  ;source columns
  (
    (* mmioshan.EXO_IS_ROM mmioshan.EXO_ID)
    (* mmioshan.EXO_IS_ROM mmioshan.INDEX_X)
    (* mmioshan.EXO_IS_ROM mmioshan.LIMB)
    (* mmioshan.EXO_IS_ROM mmioshan.TOTAL_SIZE)
  ))



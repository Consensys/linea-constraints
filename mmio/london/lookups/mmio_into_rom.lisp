(defclookup
  (mmio-into-rom :unchecked)
  ;; target columns
  (
    rom.CFI
    rom.LIMB_INDEX
    rom.LIMB
    rom.CODE_SIZE
  )
  ;; source selector
  mmio.EXO_IS_ROM
  ;; source columns
  (
    mmio.EXO_ID
    mmio.INDEX_X
    mmio.LIMB
    mmio.TOTAL_SIZE
  ))



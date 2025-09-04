(defclookup
  mmio-into-blsdata
  ;; target columns
  (
    bls.ID
    bls.PHASE
    bls.INDEX
    bls.LIMB
    bls.TOTAL_SIZE
    bls.SUCCESS_BIT
  )
  ;; source selector
  mmio.EXO_IS_BLS
  ;; source columns
  (
   mmio.EXO_ID
   mmio.PHASE
   mmio.INDEX_X
   mmio.LIMB
   mmio.TOTAL_SIZE
   mmio.SUCCESS_BIT
  ))



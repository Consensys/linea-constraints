(deflookup
  mmio-into-ripsha
  ;reference columns
  (
    shakiradata.ID
    shakiradata.PHASE
    shakiradata.INDEX
    shakiradata.LIMB
    shakiradata.nBYTES
    shakiradata.TOTAL_SIZE
  )
  ;source columns
  (
    (* mmioshan.EXO_IS_RIPSHA mmioshan.EXO_ID)
    (* mmioshan.EXO_IS_RIPSHA mmioshan.PHASE)
    (* mmioshan.EXO_IS_RIPSHA mmioshan.INDEX_X)
    (* mmioshan.EXO_IS_RIPSHA mmioshan.LIMB)
    (* mmioshan.EXO_IS_RIPSHA mmioshan.SIZE)
    (* mmioshan.EXO_IS_RIPSHA mmioshan.TOTAL_SIZE)
  ))

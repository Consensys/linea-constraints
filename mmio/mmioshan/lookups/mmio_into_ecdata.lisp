(deflookup
  mmio-into-ecdata
  ;reference columns
  (
    ecdata.ID
    ecdata.PHASE
    ecdata.INDEX
    ecdata.LIMB
    ecdata.TOTAL_SIZE
    ecdata.SUCCESS_BIT
  )
  ;source columns
  (
    (* mmioshan.EXO_IS_ECDATA mmioshan.EXO_ID)
    (* mmioshan.EXO_IS_ECDATA mmioshan.PHASE)
    (* mmioshan.EXO_IS_ECDATA mmioshan.INDEX_X)
    (* mmioshan.EXO_IS_ECDATA mmioshan.LIMB)
    (* mmioshan.EXO_IS_ECDATA mmioshan.TOTAL_SIZE)
    (* mmioshan.EXO_IS_ECDATA mmioshan.SUCCESS_BIT)
  ))



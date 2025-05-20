(deflookup
  mmio-into-logdata
  ;reference columns
  (
    logdata.ABS_LOG_NUM
    logdata.INDEX
    logdata.LIMB
    logdata.SIZE_LIMB
    logdata.SIZE_TOTAL
  )
  ;source columns
  (
    (* mmioshan.EXO_IS_LOG mmioshan.EXO_ID)
    (* mmioshan.EXO_IS_LOG mmioshan.INDEX_X)
    (* mmioshan.EXO_IS_LOG mmioshan.LIMB)
    (* mmioshan.EXO_IS_LOG mmioshan.SIZE)
    (* mmioshan.EXO_IS_LOG mmioshan.TOTAL_SIZE)
  ))



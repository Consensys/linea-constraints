(deflookup
  mmio-into-rlptxn
  ;reference columns
  (
    rlptxnshan.ABS_TX_NUM
    rlptxnshan.LC
    rlptxnshan.PHASE
    rlptxnshan.INDEX_DATA
    rlptxnshan.LIMB
  )
  ;source columns
  (
    (* mmioshan.EXO_IS_TXCD mmioshan.EXO_ID)
    mmioshan.EXO_IS_TXCD
    (* mmioshan.EXO_IS_TXCD mmioshan.PHASE)
    (* mmioshan.EXO_IS_TXCD mmioshan.INDEX_X)
    (* mmioshan.EXO_IS_TXCD mmioshan.LIMB)
  ))



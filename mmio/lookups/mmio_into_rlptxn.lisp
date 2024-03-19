(deflookup 
  mmio-into-rlptxn
  ;reference columns
  (
    rlpTxn.ABS_TX_NUM
    rlpTxn.PHASE
    rlpTxn.INDEX_DATA
    rlpTxn.LIMB
    rlpTxn.nBYTES
    rlpTxn.DATA_LO
  )
  ;source columns
  (
    (* mmio.EXO_SUM_INDEX_TXCD mmio.EXO_ID)
    (* mmio.EXO_SUM_INDEX_TXCD mmio.PHASE)
    (* mmio.EXO_SUM_INDEX_TXCD mmio.INDEX_X)
    (* mmio.EXO_SUM_INDEX_TXCD mmio.LIMB)
    (* mmio.EXO_SUM_INDEX_TXCD mmio.SIZE)
    (* mmio.EXO_SUM_INDEX_TXCD mmio.TOTAL_SIZE)
  ))



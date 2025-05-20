(deflookup
  txndata-into-blockdata
  ; target columns
  (
    blockdatashan.REL_BLOCK
    blockdatashan.REL_TX_NUM_MAX
    blockdatashan.COINBASE_HI
    blockdatashan.COINBASE_LO
    blockdatashan.BASEFEE
    blockdatashan.BLOCK_GAS_LIMIT
  )
  ; source columns
  (
    txndatashan.REL_BLOCK
    txndatashan.REL_TX_NUM_MAX
    txndatashan.COINBASE_HI
    txndatashan.COINBASE_LO
    txndatashan.BASEFEE
    txndatashan.BLOCK_GAS_LIMIT
  ))



(deflookup 
  txndata_into_blockdata
  ; target columns
  (
    blockdata.REL_BLOCK
    blockdata.REL_TX_NUM_MAX
    blockdata.COINBASE_HI
    blockdata.COINBASE_LO
    blockdata.BASEFEE
    blockdata.BLOCK_GAS_LIMIT
  )
  ; source columns
  (
    txnData.REL_BLOCK
    txnData.REL_TX_NUM_MAX
    txnData.COINBASE_HI
    txnData.COINBASE_LO
    txnData.BASEFEE
    txnData.BLOCK_GAS_LIMIT
  ))



(deflookup 
  txn_data_into_wcp
  ; target columns
  (
    wcp.ARGUMENT_1_HI
    wcp.ARGUMENT_1_LO
    wcp.ARGUMENT_2_HI
    wcp.ARGUMENT_2_LO
    wcp.RESULT
    wcp.INST
  )
  ; source columns
  (
    0
    txnData.ARG_ONE_LO
    0
    txnData.ARG_TWO_LO
    txnData.RES
    txnData.INST
  ))



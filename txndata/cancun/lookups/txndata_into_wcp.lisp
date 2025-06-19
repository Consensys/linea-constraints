(deflookup
  txndata-into-wcp
  ; target columns
  (
    wcp.ARGUMENT_1'1
    wcp.ARGUMENT_1'0
    wcp.ARGUMENT_2'1
    wcp.ARGUMENT_2'0
    wcp.RESULT
    wcp.INST
  )
  ; source columns
  (
    0
    (* txndata.WCP_FLAG txndata.ARG_ONE_LO)
    0
    (* txndata.WCP_FLAG txndata.ARG_TWO_LO)
    (* txndata.WCP_FLAG txndata.RES)
    (* txndata.WCP_FLAG txndata.INST)
  ))



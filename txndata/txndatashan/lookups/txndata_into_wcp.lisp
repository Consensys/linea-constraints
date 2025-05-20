(deflookup
  txndata-into-wcp
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
    (* txndatashan.WCP_FLAG txndatashan.ARG_ONE_LO)
    0
    (* txndatashan.WCP_FLAG txndatashan.ARG_TWO_LO)
    (* txndatashan.WCP_FLAG txndatashan.RES)
    (* txndatashan.WCP_FLAG txndatashan.INST)
  ))



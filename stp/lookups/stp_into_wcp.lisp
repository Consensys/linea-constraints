(deflookup
  stp-into-wcp
  ; target colums (in WCP)
  (
    wcp.ARGUMENT_1'1
    wcp.ARGUMENT_1'0
    wcp.ARGUMENT_2'1
    wcp.ARGUMENT_2'0
    wcp.RESULT
    wcp.INST
  )
  ; source columns (in STP)
  (
    (* stp.ARG_1_HI stp.WCP_FLAG)
    (* stp.ARG_1_LO stp.WCP_FLAG)
    0
    (* stp.ARG_2_LO stp.WCP_FLAG)
    (* stp.RES_LO stp.WCP_FLAG)
    (* stp.EXO_INST stp.WCP_FLAG)
  ))



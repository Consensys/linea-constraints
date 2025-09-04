(defclookup
  stp-into-wcp
  ; target colums (in WCP)
  (
    wcp.ARG_1
    wcp.ARG_2
    wcp.RES
    wcp.INST
  )
  ; source selector
  stp.WCP_FLAG
  ; source columns (in STP)
  (
    (:: stp.ARG_1_HI stp.ARG_1_LO)
    stp.ARG_2_LO
    stp.RES_LO
    stp.EXO_INST
  ))



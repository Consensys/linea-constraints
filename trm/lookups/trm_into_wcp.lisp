(deflookup
  trm-into-wcp
  ; target columns
  (
    wcp.ARG_1
    wcp.ARG_2
    wcp.RES
    wcp.INST
  )
  ; source columns
  (
    (:: trm.ARG_1_HI trm.ARG_1_LO)
    (:: trm.ARG_2_HI trm.ARG_2_LO)
    trm.RES
    trm.INST
  ))

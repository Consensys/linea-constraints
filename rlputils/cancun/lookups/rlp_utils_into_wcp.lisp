(defclookup
  rlp-utils-into-wcp
  ; target columns
  (
    wcp.ARG_1
    wcp.ARG_2
    wcp.RES
    wcp.CT_MAX
    wcp.INST
    )
  ; source selector
  rlputils.COMPT
  ; source columns
  (
    (:: rlputils.compt/ARG_1_HI rlputils.compt/ARG_1_LO)
    rlputils.compt/ARG_2_LO
    rlputils.compt/RES
    rlputils.compt/WCP_CT_MAX 
    rlputils.compt/INST
  ))

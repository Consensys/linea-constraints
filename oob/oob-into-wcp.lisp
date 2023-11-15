(defun (wcp-activation-flag)
  oob.WCP_FLAG)

(deflookup 
  oob-into-wcp
  (
    wcp.ARG_1_HI
    wcp.ARG_1_LO
    wcp.ARG_2_HI
    wcp.ARG_2_LO
    wcp.RES_LO
    wcp.INST
  )
  (
    (* [oob.OUTGOING_DATA 1] (wcp-activation-flag))
    (* [oob.OUTGOING_DATA 2] (wcp-activation-flag))
    (* [oob.OUTGOING_DATA 3] (wcp-activation-flag))
    (* [oob.OUTGOING_DATA 4] (wcp-activation-flag))
    (* oob.OUTGOING_RES_LO (wcp-activation-flag))
    (* oob.OUTGOING_INST (wcp-activation-flag))
  ))



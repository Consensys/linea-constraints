(defun (bls-into-wcp-activation-flag)
  bls.WCP_FLAG)

(deflookup
  bls-into-wcp
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
    (* bls.WCP_ARG1_HI (bls-into-wcp-activation-flag))
    (* bls.WCP_ARG1_LO (bls-into-wcp-activation-flag))
    (* bls.WCP_ARG2_HI (bls-into-wcp-activation-flag))
    (* bls.WCP_ARG2_LO (bls-into-wcp-activation-flag))
    (* bls.WCP_RES (bls-into-wcp-activation-flag))
    (* bls.WCP_INST (bls-into-wcp-activation-flag))
  ))



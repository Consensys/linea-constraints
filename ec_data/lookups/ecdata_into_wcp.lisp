(defun (ec_data-into-wcp-activation-flag)
  ec_data.WCP_FLAG)

(deflookup 
  lookup-ec_data-into-wcp
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
    (* ec_data.WCP_ARG1_HI (ec_data-into-wcp-activation-flag))
    (* ec_data.WCP_ARG1_LO (ec_data-into-wcp-activation-flag))
    (* ec_data.WCP_ARG2_HI (ec_data-into-wcp-activation-flag))
    (* ec_data.WCP_ARG2_LO (ec_data-into-wcp-activation-flag))
    (* ec_data.WCP_RES (ec_data-into-wcp-activation-flag))
    (* ec_data.WCP_INST (ec_data-into-wcp-activation-flag))
  ))



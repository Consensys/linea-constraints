(defun (gas-into-wcp-activation-flag)
  gas.IOMF)

(deflookup
  gas-into-wcp
  (
    wcp.ARGUMENT_1'1
    wcp.ARGUMENT_1'0
    wcp.ARGUMENT_2'1
    wcp.ARGUMENT_2'0
    wcp.RESULT
    wcp.INST
  )
  (
    0
    (* gas.WCP_ARG1_LO (gas-into-wcp-activation-flag))
    0
    (* gas.WCP_ARG2_LO (gas-into-wcp-activation-flag))
    (* gas.WCP_RES     (gas-into-wcp-activation-flag))
    (* gas.WCP_INST    (gas-into-wcp-activation-flag))
  ))



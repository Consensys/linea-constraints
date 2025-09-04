(defun (gas-into-wcp-activation-flag)
  gas.IOMF)

(defclookup
    gas-into-wcp
  ;; target columns
  (
    wcp.ARG_1
    wcp.ARG_2
    wcp.RES
    wcp.INST
  )
  ;; source selector
  (gas-into-wcp-activation-flag)
  ;; source columns
  (
    gas.WCP_ARG1_LO
    gas.WCP_ARG2_LO
    gas.WCP_RES
    gas.WCP_INST
  ))



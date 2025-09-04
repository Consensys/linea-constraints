(defclookup
  euc-into-wcp
  ;; target columns
  (
    wcp.ARG_1
    wcp.ARG_2
    wcp.RES
    wcp.INST
  )
  ;; source selector
  euc.DONE
  ;; source columns
  (
    euc.REMAINDER
    euc.DIVISOR
    1
    EVM_INST_LT
  ))



(deflookup
  euc-into-wcp
  ;reference columns
  (
    wcp.ARGUMENT_1'1
    wcp.ARGUMENT_1'0
    wcp.ARGUMENT_2'1
    wcp.ARGUMENT_2'0
    wcp.RESULT
    wcp.INST
  )
  ;source columns
  (
    0
    (* euc.REMAINDER euc.DONE)
    0
    (* euc.DIVISOR   euc.DONE)
    (* 1             euc.DONE)
    (* EVM_INST_LT   euc.DONE)
  ))



(deflookup
  txndata-into-euc
  ; target columns
  (
    euc.DONE
    euc.DIVIDEND
    euc.DIVISOR
    euc.QUOTIENT
  )
  ; source columns
  (
    txndatashan.EUC_FLAG
    (* txndatashan.EUC_FLAG txndatashan.ARG_ONE_LO)
    (* txndatashan.EUC_FLAG txndatashan.ARG_TWO_LO)
    (* txndatashan.EUC_FLAG txndatashan.RES)
  ))



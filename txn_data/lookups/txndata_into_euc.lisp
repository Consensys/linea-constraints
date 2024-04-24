(deflookup 
  txn_data_into_euc
  ; target columns
  (
    euc.IOMF
    euc.DIVIDEND
    euc.DIVISOR
    euc.QUOTIENT
  )
  ; source columns
  (
    1
    (* txnData.EUC_FLAG txnData.ARG_ONE_LO)
    (* txnData.EUC_FLAG txnData.ARG_TWO_LO)
    (* txnData.EUC_FLAG txnData.RES)
  ))



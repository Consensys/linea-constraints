(defclookup
  txndata-into-euc
  ;; target columns
  (
    euc.DIVIDEND
    euc.DIVISOR
    euc.QUOTIENT
  )
  ;; source selector
  txndata.EUC_FLAG
  ;; source columns
  (
    (i64 txndata.ARG_ONE_LO)
    (i64 txndata.ARG_TWO_LO)
    (i64 txndata.RES)
  ))



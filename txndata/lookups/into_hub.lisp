(deflookup txn_data_into_hub
 ;; target columns
 (
  hub.BATCH_NUMBER
  hub.ABSOLUTE_TRANSACTION_NUMBER
 )
 ;; source columns
 (
  txnData.BTC_NUM
  txnData.ABS_TX_NUM
 )
)

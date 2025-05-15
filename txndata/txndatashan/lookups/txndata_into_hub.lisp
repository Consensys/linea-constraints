(deflookup txndata-into-hub
 ;; target columns
 (
  hubshan.RELATIVE_BLOCK_NUMBER
  hubshan.ABSOLUTE_TRANSACTION_NUMBER
 )
 ;; source columns
 (
  txndatashan.REL_BLOCK
  txndatashan.ABS_TX_NUM
 )
)

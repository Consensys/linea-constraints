(deflookup
  loginfo-into-hub
  ;; target columns
  (
    hubshan.ABS_TX_NUM
    hubshan.LOG_INFO_STAMP
  )
  ;; source columns
  (
    loginfoshan.ABS_TXN_NUM
    loginfoshan.ABS_LOG_NUM
  ))

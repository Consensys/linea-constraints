(deflookup
  loginfo-into-hub
  ;; target columns
  (
    hub.ABSOLUTE_TRANSACTION_NUMBER
    hub.LOG_INFO_STAMP
  )
  ;; source columns
  (
    loginfo.ABS_TXN_NUM
    loginfo.ABS_LOG_NUM
  ))

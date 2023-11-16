(deflookup 
  logInfo-into-logdata
  ;reference columns
  (
    logData.ABS_LOG_NUM_MAX
    logData.ABS_LOG_NUM
    logData.SIZE_TOTAL
  )
  ;source columns
  (
    logInfo.ABS_LOG_NUM_MAX
    logInfo.ABS_LOG_NUM
    logInfo.DATA_SIZE
  ))



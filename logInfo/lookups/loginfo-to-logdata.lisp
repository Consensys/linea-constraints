(defpurefun (selLogInfoToLogData)
  logInfo.TXN_EMITS_LOGS)

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
    (* logInfo.ABS_LOG_NUM_MAX (selLogInfoToLogData))
    (* logInfo.ABS_LOG_NUM (selLogInfoToLogData))
    (* logInfo.DATA_SIZE (selLogInfoToLogData))
  ))



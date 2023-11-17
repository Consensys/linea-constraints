(defpurefun (sel_logInfo_to_logData)
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
    (* logInfo.ABS_LOG_NUM_MAX (sel_logInfo_to_logData))
    (* logInfo.ABS_LOG_NUM (sel_logInfo_to_logData))
    (* logInfo.DATA_SIZE (sel_logInfo_to_logData))
  ))



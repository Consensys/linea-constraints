(defun (sel-loginfo-to-logdata-shan)
  loginfoshan.TXN_EMITS_LOGS)

(deflookup
  loginfo-into-logdata
  ;; target columns
  (
    logdata.ABS_LOG_NUM_MAX
    logdata.ABS_LOG_NUM
    logdata.SIZE_TOTAL
  )
  ;; source columns
  (
    (* loginfoshan.ABS_LOG_NUM_MAX (sel-loginfo-to-logdata-shan))
    (* loginfoshan.ABS_LOG_NUM (sel-loginfo-to-logdata-shan))
    (* loginfoshan.DATA_SIZE (sel-loginfo-to-logdata-shan))
  ))



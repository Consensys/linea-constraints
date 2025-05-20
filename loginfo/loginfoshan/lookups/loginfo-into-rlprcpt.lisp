(deflookup
  loginfo-into-rlptxrcpt
  ;; target columns
  (
    rlptxrcpt.ABS_TX_NUM_MAX
    rlptxrcpt.ABS_TX_NUM
    rlptxrcpt.ABS_LOG_NUM_MAX
    rlptxrcpt.ABS_LOG_NUM
    rlptxrcpt.PHASE_ID
    [rlptxrcpt.INPUT 1]
    [rlptxrcpt.INPUT 2]
  )
  ;; source columns
  (
    loginfoshan.ABS_TXN_NUM_MAX
    loginfoshan.ABS_TXN_NUM
    loginfoshan.ABS_LOG_NUM_MAX
    loginfoshan.ABS_LOG_NUM
    loginfoshan.PHASE
    loginfoshan.DATA_HI
    loginfoshan.DATA_LO
  ))



(module log_info)

(defcolumns 
  ABS_TXN_NUM_MAX
  ABS_TXN_NUM
  (TXN_EMITS_LOGS :binary)
  ABS_LOG_NUM_MAX
  ABS_LOG_NUM
  CT_MAX
  CT
  ADDR_HI
  ADDR_LO
  (TOPIC_HI :array [1:4])
  (TOPIC_LO :array [1:4])
  DATA_SIZE
  INST
  (IS_LOG_X :binary :array [0:4])
  ;; lookup columns
  PHASE
  DATA_HI
  DATA_LO)



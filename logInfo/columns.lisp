(module logInfo)

(defcolumns 
  (ABS_TXN_NUM_MAX :i3)
  (ABS_TXN_NUM :i3)
  (TXN_EMITS_LOGS :binary@prove)
  (ABS_LOG_NUM_MAX :i3)
  (ABS_LOG_NUM :i3)
  (CT_MAX :byte)
  (CT :byte)
  (ADDR_HI :i4)
  (ADDR_LO :i16)
  (TOPIC_HI :array [4])
  (TOPIC_LO :array [4])
  (DATA_SIZE :i4)
  (INST :byte :display :opcode)
  (IS_LOG_X :binary@prove :array [0:4])
  ;; lookup columns
  (PHASE :byte)
  (DATA_HI :i16)
  (DATA_LO :i16))



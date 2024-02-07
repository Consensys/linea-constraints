(module rlpTxRcpt)

(defcolumns 
  (ABS_TX_NUM :i32)
  (ABS_TX_NUM_MAX :i32)
  (ABS_LOG_NUM :i32)
  (ABS_LOG_NUM_MAX :i32)
  (LIMB :i128 :display :bytes)
  (nBYTES :i5)
  (LIMB_CONSTRUCTED :binary)
  (INDEX :i16)
  (INDEX_LOCAL :i16)
  (PHASE :binary@prove :array [5])
  (PHASE_END :binary)
  (COUNTER :i5)
  (nSTEP :i5)
  (DONE :binary)
  (TXRCPT_SIZE :i32)
  (INPUT :i128 :display :bytes :array [4])
  (BYTE :byte@prove :array [4])
  (ACC :i128 :display :bytes :array [4])
  (ACC_SIZE :i5)
  (BIT :binary@prove)
  (BIT_ACC :byte)
  (POWER :i128)
  (IS_PREFIX :binary)
  (LC_CORRECTION :binary)
  (PHASE_SIZE :i32)
  (DEPTH_1 :binary)
  (IS_TOPIC :binary)
  (IS_DATA :binary)
  (LOG_ENTRY_SIZE :i32)
  (LOCAL_SIZE :i32)
  (PHASE_ID :i16))

;; aliases
(defalias 
  CT COUNTER
  LC LIMB_CONSTRUCTED
  P  POWER)



(module rlpTxRcpt)

(defcolumns 
  (ABS_TX_NUM :i2)
  (ABS_TX_NUM_MAX :i2)
  (ABS_LOG_NUM :i3)
  (ABS_LOG_NUM_MAX :i3)
  (LIMB :i16 :display :bytes)
  (nBYTES :byte)
  (LIMB_CONSTRUCTED :binary@prove)
  (INDEX :i2)
  (INDEX_LOCAL :i2)
  (PHASE :binary@prove :array [5])
  (PHASE_END :binary@prove)
  (COUNTER :byte)
  (nSTEP :byte)
  (DONE :binary@prove)
  (TXRCPT_SIZE :i4)
  (INPUT :i16 :display :bytes :array [4])
  (BYTE :byte@prove :array [4])
  (ACC :i16 :display :bytes :array [4])
  (ACC_SIZE :byte)
  (BIT :binary@prove)
  (BIT_ACC :byte)
  (POWER :i16)
  (IS_PREFIX :binary@prove)
  (LC_CORRECTION :binary@prove)
  (PHASE_SIZE :i4)
  (DEPTH_1 :binary@prove)
  (IS_TOPIC :binary@prove)
  (IS_DATA :binary@prove)
  (LOG_ENTRY_SIZE :i4)
  (LOCAL_SIZE :i4))

;; aliases
(defalias 
  CT COUNTER
  LC LIMB_CONSTRUCTED
  P  POWER)



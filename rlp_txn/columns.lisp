(module rlpTxn)

(defcolumns 
  (ABS_TX_NUM :i2)
  (LIMB :i16)
  (nBYTES :byte)
  (LIMB_CONSTRUCTED :binary@prove)
  (LT :binary@prove)
  (LX :binary@prove)
  (INDEX_LT :i4)
  (INDEX_LX :i4)
  (ABS_TX_NUM_INFINY :i2)
  (DATA_HI :i16)
  (DATA_LO :i16)
  (CODE_FRAGMENT_INDEX :i3)
  (REQUIRES_EVM_EXECUTION :binary@prove)
  (PHASE :binary@prove :array [0:14])
  (PHASE_END :binary@prove)
  (TYPE :byte)
  (COUNTER :byte)
  (DONE :binary@prove)
  (nSTEP :byte)
  (INPUT :display :bytes :array [2])
  (BYTE :byte@prove :array [2])
  (ACC :display :bytes :array [2])
  (ACC_BYTESIZE :byte)
  (BIT :binary@prove)
  (BIT_ACC :byte)
  (POWER :i16)
  (RLP_LT_BYTESIZE :i3)
  (RLP_LX_BYTESIZE :i3)
  (LC_CORRECTION :binary@prove)
  (IS_PREFIX :binary@prove)
  (PHASE_SIZE :i3)
  (INDEX_DATA :i3)
  (DATAGASCOST :i4)
  (DEPTH :binary@prove :array [2])
  (ADDR_HI :i4)
  (ADDR_LO :i16)
  (ACCESS_TUPLE_BYTESIZE :i3)
  (nADDR :i2)
  (nKEYS :i2)
  (nKEYS_PER_ADDR :i2))

;; aliases
(defalias 
  CT  COUNTER
  LC  LIMB_CONSTRUCTED
  P   POWER
  CFI CODE_FRAGMENT_INDEX)



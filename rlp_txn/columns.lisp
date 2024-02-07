(module rlpTxn)

(defcolumns 
  (ABS_TX_NUM :i32)
  (LIMB :i128)
  (nBYTES :i5)
  (LIMB_CONSTRUCTED :binary)
  (LT :binary)
  (LX :binary)
  (INDEX_LT :i32)
  (INDEX_LX :i32)
  (ABS_TX_NUM_INFINY :i16)
  (DATA_HI :i128)
  (DATA_LO :i128)
  (CODE_FRAGMENT_INDEX :i32)
  (REQUIRES_EVM_EXECUTION :binary)
  (PHASE :binary@prove :array [0:14])
  (PHASE_END :binary)
  (TYPE :i3)
  (COUNTER :i5)
  (DONE :binary)
  (nSTEP :i5)
  (INPUT :i128 :display :bytes :array [2])
  (BYTE :byte@prove :array [2])
  (ACC :i128 :display :bytes :array [2])
  (ACC_BYTESIZE :i5)
  (BIT :binary@prove)
  (BIT_ACC :byte)
  (POWER :i128)
  (RLP_LT_BYTESIZE :i24)
  (RLP_LX_BYTESIZE :i24)
  (LC_CORRECTION :binary)
  (IS_PREFIX :binary)
  (PHASE_SIZE :i32)
  (INDEX_DATA :i32)
  (DATAGASCOST :i32)
  (DEPTH :binary :array [2])
  (ADDR_HI :i32)
  (ADDR_LO :i128)
  (ACCESS_TUPLE_BYTESIZE :i24)
  (nADDR :i16)
  (nKEYS :i16)
  (nKEYS_PER_ADDR :i16)
  (PHASE_ID :i5))

;; aliases
(defalias 
  CT  COUNTER
  LC  LIMB_CONSTRUCTED
  P   POWER
  CFI CODE_FRAGMENT_INDEX)



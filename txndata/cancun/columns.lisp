(module txndata)

;;TODO: rewrite me completely

(defcolumns
  (ABS_TX_NUM_MAX          :i16)
  (ABS_TX_NUM              :i16)
  (REL_BLOCK               :i16)
  (REL_TX_NUM_MAX          :i16)
  (REL_TX_NUM              :i16)
  (CT                      :byte)
  (FROM_HI                 :i32)
  (FROM_LO                 :i128)
  (NONCE                   :i64)
  (INITIAL_BALANCE         :i128)
  (VALUE                   :i128)
  (TO_HI                   :i32)
  (TO_LO                   :i128)
  (IS_DEP                  :binary@prove)
  (GAS_LIMIT               :i64)
  (GAS_INITIALLY_AVAILABLE :i128)
  (GAS_PRICE               :i64)
  (PRIORITY_FEE_PER_GAS    :i128)
  (BASEFEE                 :i128)
  (COINBASE_HI             :i32)
  (COINBASE_LO             :i128)
  (BLOCK_GAS_LIMIT         :i64)
  (CALL_DATA_SIZE          :i32)
  (INIT_CODE_SIZE          :i32)
  (TYPE0                   :binary@prove)
  (TYPE1                   :binary@prove)
  (TYPE2                   :binary@prove)
  (REQUIRES_EVM_EXECUTION  :binary@prove)
  (COPY_TXCD               :binary@prove)
  (GAS_LEFTOVER            :i128)
  (REFUND_COUNTER          :i128)
  (REFUND_EFFECTIVE        :i128)
  (GAS_CUMULATIVE          :i128)
  (STATUS_CODE             :binary@prove)
  (PHASE_RLP_TXN           :byte)
  (PHASE_RLP_TXNRCPT       :byte)
  (CODE_FRAGMENT_INDEX     :i32)
  (OUTGOING_HI             :i64)
  (OUTGOING_LO             :i128)
  (OUTGOING_RLP_TXNRCPT    :i128)
  (EUC_FLAG                :binary)
  (WCP_FLAG                :binary)
  (ARG_ONE_LO              :i128)
  (ARG_TWO_LO              :i128)
  (RES                     :i64)
  (INST                    :byte :display :opcode)
  (IS_LAST_TX_OF_BLOCK     :binary))

(defalias
  ABS_MAX ABS_TX_NUM_MAX
  ABS     ABS_TX_NUM
  BLK     REL_BLOCK
  REL_MAX REL_TX_NUM_MAX
  REL     REL_TX_NUM
  REQ_EVM REQUIRES_EVM_EXECUTION
  CUM_GAS GAS_CUMULATIVE
  CFI     CODE_FRAGMENT_INDEX
  REF_CNT REFUND_COUNTER
  IGAS    GAS_INITIALLY_AVAILABLE
  IBAL    INITIAL_BALANCE
  GLIM    GAS_LIMIT
  GPRC    GAS_PRICE)



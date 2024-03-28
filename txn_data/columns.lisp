(module txnData)

(defcolumns 
  (ABS_TX_NUM_MAX              :i16)
  (ABS_TX_NUM                  :i16)
  (BTC_NUM_MAX                 :i16)
  (BTC_NUM                     :i16)
  (REL_TX_NUM_MAX              :i16)
  (REL_TX_NUM                  :i16)
  (CT                          :byte)
  (FROM_HI                     :i32)
  (FROM_LO                     :i128)
  (NONCE                       :i64)
  (INITIAL_BALANCE             :i128)
  (VALUE                       :i128)
  (TO_HI                       :i32)
  (TO_LO                       :i128)
  (IS_DEP                      :binary@prove)
  (GAS_LIMIT                   :i64)
  (INITIAL_GAS                 :i128)
  (GAS_PRICE                   :i64)
  (PRIORITY_FEE_PER_GAS        :i64)          ;; TODO: constrain
  (BASEFEE                     :i128)
  (COINBASE_HI                 :i128)
  (COINBASE_LO                 :i128)
  (CALL_DATA_SIZE              :i32)
  (INIT_CODE_SIZE              :i32)
  (TYPE0                       :binary@prove)
  (TYPE1                       :binary@prove)
  (TYPE2                       :binary@prove)
  (REQUIRES_EVM_EXECUTION      :binary@prove)
  (COPY_TXCD                   :binary)
  LEFTOVER_GAS
  REFUND_COUNTER
  REFUND_EFFECTIVE
  CUMULATIVE_CONSUMED_GAS
  (STATUS_CODE         :binary@prove)
  (PHASE_RLP_TXN       :byte)
  (PHASE_RLP_TXNRCPT   :byte)
  (CODE_FRAGMENT_INDEX :i24)
  (OUTGOING_HI         :i128)
  (OUTGOING_LO         :i128)
  OUTGOING_RLP_TXNRCPT
  (WCP_ARG_ONE_LO      :i128)
  (WCP_ARG_TWO_LO      :i128)
  (WCP_RES             :binary)
  (WCP_INST            :byte :display :opcode))

(defalias 
  ABS_MAX ABS_TX_NUM_MAX
  ABS     ABS_TX_NUM
  BTC_MAX BTC_NUM_MAX
  BTC     BTC_NUM
  REL_MAX REL_TX_NUM_MAX
  REL     REL_TX_NUM
  REQ_EVM REQUIRES_EVM_EXECUTION
  CUM_GAS CUMULATIVE_CONSUMED_GAS
  CFI     CODE_FRAGMENT_INDEX
  REF_CNT REFUND_COUNTER
  REF_EFF REFUND_EFFECTIVE
  IGAS    INITIAL_GAS
  IBAL    INITIAL_BALANCE
  GLIM    GAS_LIMIT
  GPRC    GAS_PRICE)



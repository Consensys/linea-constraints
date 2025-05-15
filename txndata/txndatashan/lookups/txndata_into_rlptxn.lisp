(deflookup
  txndata-into-rlptxn
  ;; target columns
  (
    rlptxnshan.ABS_TX_NUM_INFINY
    rlptxnshan.ABS_TX_NUM
    rlptxnshan.CODE_FRAGMENT_INDEX
    rlptxnshan.PHASE
    rlptxnshan.DATA_HI
    rlptxnshan.DATA_LO
  )
  ;; source columns
  (
    txndatashan.ABS_TX_NUM_MAX
    txndatashan.ABS_TX_NUM
    txndatashan.CODE_FRAGMENT_INDEX
    txndatashan.PHASE_RLP_TXN
    txndatashan.OUTGOING_HI
    txndatashan.OUTGOING_LO
  ))



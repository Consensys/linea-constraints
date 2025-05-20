(deflookup
  txndata-into-rlptxrcpt
  ;; target columns
  (
    rlptxrcpt.ABS_TX_NUM_MAX
    rlptxrcpt.ABS_TX_NUM
    rlptxrcpt.PHASE_ID
    [rlptxrcpt.INPUT 1]
  )
  ;; source columns
  (
    (* txndatashan.ABS_TX_NUM_MAX (~ txndatashan.PHASE_RLP_TXNRCPT))
    (* txndatashan.ABS_TX_NUM (~ txndatashan.PHASE_RLP_TXNRCPT))
    (* txndatashan.PHASE_RLP_TXNRCPT (~ txndatashan.PHASE_RLP_TXNRCPT))
    (* txndatashan.OUTGOING_RLP_TXNRCPT (~ txndatashan.PHASE_RLP_TXNRCPT))
  ))



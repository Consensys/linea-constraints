(deflookup 
  logData-into-rlpRcpt
  ;reference columns
  (
    rlpTxRcpt.ABS_LOG_NUM
    (subphaseId-rlp-txrcpt)
    rlpTxRcpt.INDEX_LOCAL
    rlpTxRcpt.LIMB
    rlpTxRcpt.nBYTES
  )
  ;source columns
  (
    logData.ABS_LOG_NUM
    RLPRECEIPT_SUBPHASE_ID_DATA_LIMB
    logData.INDEX
    logData.LIMB
    logData.SIZE_LIMB
  ))



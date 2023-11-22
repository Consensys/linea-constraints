(defpurefun (selLogDataToRlpRcpt)
  logData.LOGS_DATA)

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
    (* logData.ABS_LOG_NUM (selLogDataToRlpRcpt))
    (* RLPRECEIPT_SUBPHASE_ID_DATA_LIMB (selLogDataToRlpRcpt))
    (* logData.INDEX (selLogDataToRlpRcpt))
    (* logData.LIMB (selLogDataToRlpRcpt))
    (* logData.SIZE_LIMB (selLogDataToRlpRcpt))
  ))



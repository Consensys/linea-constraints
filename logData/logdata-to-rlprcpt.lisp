(defpurefun (sel_logData_to_rlpRcpt)
  (~ logData.ABS_LOG_NUM))

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
    (* RLPRECEIPT_SUBPHASE_ID_DATA_LIMB (sel_logData_to_rlpRcpt))
    (* logData.INDEX (sel_logData_to_rlpRcpt))
    (* logData.LIMB (sel_logData_to_rlpRcpt))
    (* logData.SIZE_LIMB (sel_logData_to_rlpRcpt))
  ))



(defun (selTxnDataToRlpAddr)
  txnData.IS_DEP)

(deflookup 
  txnData-into-rlpAddr
  ;reference columns
  (
    rlpAddr.ADDR_HI
    rlpAddr.ADDR_LO
    rlpAddr.DEP_ADDR_HI
    rlpAddr.DEP_ADDR_LO
    rlpAddr.NONCE
    rlpAddr.RECIPE_1
  )
  ;source columns
  (
    (* txnData.FROM_HI (selTxnDataToRlpAddr))
    (* txnData.FROM_LO (selTxnDataToRlpAddr))
    (* txnData.TO_HI (selTxnDataToRlpAddr))
    (* txnData.TO_LO (selTxnDataToRlpAddr))
    (* txnData.NONCE (selTxnDataToRlpAddr))
    (* txnData.IS_DEP (selTxnDataToRlpAddr))
  ))



(defun (selTxnDataToRomLex)
  (* txnData.IS_DEP (~ txnData.INIT_CODE_SIZE)))

(deflookup 
  txnData-into-romLex
  ;reference columns
  (
    romLex.CODE_FRAGMENT_INDEX
    romLex.CODE_SIZE
    romLex.ADDR_HI
    romLex.ADDR_LO
    romLex.DEP_NUMBER
    romLex.DEP_STATUS
  )
  ;source columns
  (
    (* txnData.CODE_FRAGMENT_INDEX (selTxnDataToRomLex))
    (* txnData.INIT_CODE_SIZE (selTxnDataToRomLex))
    (* txnData.TO_HI (selTxnDataToRomLex))
    (* txnData.TO_LO (selTxnDataToRomLex))
    (selTxnDataToRomLex)
    (selTxnDataToRomLex)
  ))



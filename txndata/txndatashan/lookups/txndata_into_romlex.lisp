(defun (sel-txn-data-to-rom-lex-shan)
  (* txndatashan.IS_DEP (~ txndatashan.INIT_CODE_SIZE)))

(deflookup
  txndata-into-romlex
  ;; target columns
  (
    romlex.CODE_FRAGMENT_INDEX
    romlex.CODE_SIZE
    romlex.ADDRESS_HI
    romlex.ADDRESS_LO
    romlex.DEPLOYMENT_NUMBER
    romlex.DEPLOYMENT_STATUS
  )
  ;; source columns
  (
    (* txndatashan.CODE_FRAGMENT_INDEX (sel-txn-data-to-rom-lex-shan))
    (* txndatashan.INIT_CODE_SIZE (sel-txn-data-to-rom-lex-shan))
    (* txndatashan.TO_HI (sel-txn-data-to-rom-lex-shan))
    (* txndatashan.TO_LO (sel-txn-data-to-rom-lex-shan))
    (sel-txn-data-to-rom-lex-shan)
    (sel-txn-data-to-rom-lex-shan)
  ))



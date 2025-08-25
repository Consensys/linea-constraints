(defun   (txn-data-into-rom-lex-product)   (*   txndata.USER
                                                txndata.HUB
                                                txndata.hub/IS_DEPLOYMENT
                                                txndata.hub/INIT_CODE_SIZE
                                                ))
(defun   (txn-data-into-rom-lex-selector)   (if-zero   (txn-data-into-rom-lex-product)
                                                       0 ;; zero
                                                       1 ;; nonzero
                                                       ))

(defclookup
  txndata-into-rom-lex
  ; target columns
  (
   romlex.CODE_FRAGMENT_INDEX
   romlex.CODE_SIZE
   romlex.ADDRESS_HI
   romlex.ADDRESS_LO
   romlex.DEPLOYMENT_NUMBER
   romlex.DEPLOYMENT_STATUS
   )
  ; source selector
  (txn-data-into-rom-lex-selector)
  ; source columns
  (
   txndata.hub/CFI
   txndata.hub/INIT_CODE_SIZE
   txndata.hub/TO_ADDRESS_HI
   txndata.hub/TO_ADDRESS_LO
   1
   1
   )
  )


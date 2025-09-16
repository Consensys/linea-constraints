(defun (hub-into-txn-data-trigger) hub.PEEK_AT_TRANSACTION)
(defun ((txn-data---priority-fee-per-gas :force :i64))  (- txndata.hub/GAS_PRICE txndata.hub/btc_BASEFEE ))

;; ""

(defclookup (hub-into-txndata :unchecked)
  ;; target columns
  (
   txndata.TOTL_TXN_NUMBER
   txndata.BLK_NUMBER
   txndata.hub/FROM_ADDRESS_HI
   txndata.hub/FROM_ADDRESS_LO
   txndata.hub/TO_ADDRESS_HI
   txndata.hub/TO_ADDRESS_LO
   txndata.hub/btc_COINBASE_ADDRESS_HI
   txndata.hub/btc_COINBASE_ADDRESS_LO
   ;;
   txndata.hub/NONCE
   txndata.hub/VALUE
   txndata.hub/IS_DEPLOYMENT
   txndata.hub/HAS_EIP_1559_GAS_SEMANTICS
   txndata.hub/GAS_PRICE
   txndata.hub/GAS_LIMIT
   (txn-data---priority-fee-per-gas)
   txndata.hub/btc_BASEFEE
   txndata.hub/CALL_DATA_SIZE
   txndata.hub/INIT_CODE_SIZE
   ;;
   txndata.hub/GAS_INITIALLY_AVAILABLE
   txndata.hub/INIT_BALANCE
   txndata.hub/REQUIRES_EVM_EXECUTION
   txndata.hub/COPY_TXCD
   txndata.hub/STATUS_CODE
   txndata.hub/GAS_LEFTOVER
   txndata.hub/REFUND_COUNTER_FINAL
   txndata.hub/REFUND_EFFECTIVE
  )
  ;; source selector
  (hub-into-txn-data-trigger)  
  ;; source columns
  (
   hub.TOTL_TXN_NUMBER
   hub.BLK_NUMBER
   hub.transaction/FROM_ADDRESS_HI
   hub.transaction/FROM_ADDRESS_LO
   hub.transaction/TO_ADDRESS_HI
   hub.transaction/TO_ADDRESS_LO
   hub.transaction/COINBASE_ADDRESS_HI
   hub.transaction/COINBASE_ADDRESS_LO
   ;;
   hub.transaction/NONCE
   hub.transaction/VALUE
   hub.transaction/IS_DEPLOYMENT
   hub.transaction/IS_TYPE2
   hub.transaction/GAS_PRICE
   hub.transaction/GAS_LIMIT
   hub.transaction/PRIORITY_FEE_PER_GAS
   hub.transaction/BASEFEE
   hub.transaction/CALL_DATA_SIZE
   hub.transaction/INIT_CODE_SIZE
   ;;
   hub.transaction/GAS_INITIALLY_AVAILABLE
   hub.transaction/INITIAL_BALANCE
   hub.transaction/REQUIRES_EVM_EXECUTION
   hub.transaction/COPY_TXCD
   hub.transaction/STATUS_CODE
   hub.transaction/GAS_LEFTOVER
   hub.transaction/REFUND_COUNTER_INFINITY
   hub.transaction/REFUND_EFFECTIVE
  )
)

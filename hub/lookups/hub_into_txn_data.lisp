(defun (hub-into-txn-data-trigger) hub.PEEK_AT_TRANSACTION)

(deflookup hub-into-txn-data
           ;; target columns
           (
            txnData.ABS_TX_NUM
            txnData.BTC_NUM
            txnData.FROM_HI
            txnData.FROM_LO
            txnData.TO_HI
            txnData.TO_LO
            txnData.COINBASE_HI
            txnData.COINBASE_LO
            ;;
            txnData.NONCE
            txnData.VALUE
            txnData.IS_DEP
            txnData.TYPE2
            txnData.GAS_PRICE
            txnData.PRIORITY_FEE_PER_GAS
            txnData.BASEFEE
            txnData.CALL_DATA_SIZE
            txnData.INIT_CODE_SIZE
            ;;
            txnData.GAS_INITIALLY_AVAILABLE
            txnData.INITIAL_BALANCE
            txnData.REQUIRES_EVM_EXECUTION
            txnData.COPY_TXCD
            txnData.STATUS_CODE
            txnData.LEFTOVER_GAS
            txnData.REFUND_COUNTER
            txnData.REFUND_EFFECTIVE
            )
           ;; source columns
           (
            (* hub.ABSOLUTE_TRANSACTION_NUMBER                                      (hub-into-txn-data-trigger))
            (* hub.transaction/BATCH_NUM                                            (hub-into-txn-data-trigger))
            (* hub.transaction/FROM_ADDRESS_HI                                      (hub-into-txn-data-trigger))
            (* hub.transaction/FROM_ADDRESS_LO                                      (hub-into-txn-data-trigger))
            (* hub.transaction/TO_ADDRESS_HI                                        (hub-into-txn-data-trigger))
            (* hub.transaction/TO_ADDRESS_LO                                        (hub-into-txn-data-trigger))
            (* hub.transaction/COINBASE_ADDRESS_HI                                  (hub-into-txn-data-trigger))
            (* hub.transaction/COINBASE_ADDRESS_LO                                  (hub-into-txn-data-trigger))
            ;;
            (* hub.transaction/NONCE                                                (hub-into-txn-data-trigger))
            (* hub.transaction/VALUE                                                (hub-into-txn-data-trigger))
            (* hub.transaction/IS_DEPLOYMENT                                        (hub-into-txn-data-trigger))
            (* hub.transaction/IS_TYPE2                                             (hub-into-txn-data-trigger))
            (* hub.transaction/GAS_PRICE                                            (hub-into-txn-data-trigger))
            (* hub.transaction/PRIORITY_FEE_PER_GAS                                 (hub-into-txn-data-trigger))
            (* hub.transaction/BASEFEE                                              (hub-into-txn-data-trigger))
            (* hub.transaction/CALL_DATA_SIZE                                       (hub-into-txn-data-trigger))
            (* hub.transaction/INIT_CODE_SIZE                                       (hub-into-txn-data-trigger))
            ;;
            (* hub.transaction/GAS_INITIALLY_AVAILABLE                              (hub-into-txn-data-trigger))
            (* hub.transaction/INITIAL_BALANCE                                      (hub-into-txn-data-trigger))
            (* hub.transaction/REQUIRES_EVM_EXECUTION                               (hub-into-txn-data-trigger))
            (* hub.transaction/COPY_TXCD                                            (hub-into-txn-data-trigger))
            (* hub.transaction/STATUS_CODE                                          (hub-into-txn-data-trigger))
            (* hub.transaction/LEFTOVER_GAS                                         (hub-into-txn-data-trigger))
            (* hub.transaction/REFUND_COUNTER_INFINITY                              (hub-into-txn-data-trigger))
            (* hub.transaction/REFUND_EFFECTIVE                                     (hub-into-txn-data-trigger))
            )
           )

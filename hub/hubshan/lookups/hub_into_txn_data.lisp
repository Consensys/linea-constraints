(defun (hub-into-txn-data-trigger-shan) hubshan.PEEK_AT_TRANSACTION)

(deflookup hub-into-txndata
           ;; target columns
           (
            txndatashan.ABS_TX_NUM
            txndatashan.REL_BLOCK
            txndatashan.FROM_HI
            txndatashan.FROM_LO
            txndatashan.TO_HI
            txndatashan.TO_LO
            txndatashan.COINBASE_HI
            txndatashan.COINBASE_LO
            ;;
            txndatashan.NONCE
            txndatashan.VALUE
            txndatashan.IS_DEP
            txndatashan.TYPE2
            txndatashan.GAS_PRICE
            txndatashan.GAS_LIMIT
            txndatashan.PRIORITY_FEE_PER_GAS
            txndatashan.BASEFEE
            txndatashan.CALL_DATA_SIZE
            txndatashan.INIT_CODE_SIZE
            ;;
            txndatashan.GAS_INITIALLY_AVAILABLE
            txndatashan.INITIAL_BALANCE
            txndatashan.REQUIRES_EVM_EXECUTION
            txndatashan.COPY_TXCD
            txndatashan.STATUS_CODE
            txndatashan.GAS_LEFTOVER
            txndatashan.REFUND_COUNTER
            txndatashan.REFUND_EFFECTIVE
            )
           ;; source columns
           (
            (* hubshan.ABSOLUTE_TRANSACTION_NUMBER                                      (hub-into-txn-data-trigger-shan))
            (* hubshan.RELATIVE_BLOCK_NUMBER                                            (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/FROM_ADDRESS_HI                                      (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/FROM_ADDRESS_LO                                      (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/TO_ADDRESS_HI                                        (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/TO_ADDRESS_LO                                        (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/COINBASE_ADDRESS_HI                                  (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/COINBASE_ADDRESS_LO                                  (hub-into-txn-data-trigger-shan))
            ;;
            (* hubshan.transaction/NONCE                                                (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/VALUE                                                (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/IS_DEPLOYMENT                                        (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/IS_TYPE2                                             (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/GAS_PRICE                                            (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/GAS_LIMIT                                            (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/PRIORITY_FEE_PER_GAS                                 (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/BASEFEE                                              (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/CALL_DATA_SIZE                                       (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/INIT_CODE_SIZE                                       (hub-into-txn-data-trigger-shan))
            ;;
            (* hubshan.transaction/GAS_INITIALLY_AVAILABLE                              (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/INITIAL_BALANCE                                      (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/REQUIRES_EVM_EXECUTION                               (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/COPY_TXCD                                            (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/STATUS_CODE                                          (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/GAS_LEFTOVER                                         (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/REFUND_COUNTER_INFINITY                              (hub-into-txn-data-trigger-shan))
            (* hubshan.transaction/REFUND_EFFECTIVE                                     (hub-into-txn-data-trigger-shan))
            )
           )

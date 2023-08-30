;; (defun (sel))

(defplookup txn_data_into_wcp
    ; target columns
    (
            txn_data.ABS_TX_NUM_MAX
            txn_data.ABS_TX_NUM
            txn_data.BTC_NUM
            ;;
            txn_data.FROM_HI
            txn_data.FROM_LO
            txn_data.NONCE
            txn_data.VALUE
            txn_data.INITIAL_BALANCE
            ;;
            txn_data.TO_HI
            txn_data.TO_LO
            txn_data.IS_DEP
            ;;
            txn_data.GAS_LIMIT
            txn_data.INIT_GAS
            txn_data.
    )
    ; source columns
    (
    )
)


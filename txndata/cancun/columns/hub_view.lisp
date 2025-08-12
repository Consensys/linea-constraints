(module txndata)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;    X.Y.Y HUB-view columns    ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defperspective hub

	;; selector
	HUB

	;; HUB view columns
        (
                ;; block data from BTC module
                ( btc_BLOCK_NUMBER           :i16 )
                ( btc_BLOCK_GAS_LIMIT        :i32 )
                ( btc_BASEFEE                :i8 )
                ( btc_TIMESTAMP              :i64 )
                ( btc_COINBASE_ADDRESS_HI    :i32 )
                ( btc_COINBASE_ADDRESS_LO    :i128 )
		;;
                ( TO_ADDRESS_HI              :i32 )
                ( TO_ADDRESS_LO              :i128 )
                ( FROM_ADDRESS_HI            :i32 )
                ( FROM_ADDRESS_LO            :i128 )
                ( IS_DEPLOYMENT              :binary@prove )
                ( NONCE                      :i32 )
                ( VALUE                      :i32 )
                ( GAS_LIMIT                  :i32 )
                ( GAS_PRICE                  :i32 )
                ( GAS_INITIALLY_AVAILABLE    :i32 )
                ( CALL_DATA_SIZE             :i32 )
                ( INIT_CODE_SIZE             :i32 )
                ( HAS_EIP_1559_GAS_SEMANTICS :i32 )
                ( REQUIRES_EVM_EXECUTION     :i32 )
                ( COPY_TXCD                  :i32 )
                ( CFI                        :i32 )
                ( INIT_BALANCE               :i32 )
                ( STATUS_CODE                :i32 )
                ( GAS_LEFTOVER               :i32 )
                ( REFUND_COUNTER_FINAL       :i32 )
                ( REFUND_EFFECTIVE           :i32 )
                ( EIP_4788                   :i32 )
                ( EIP_2935                   :i32 )
                ( NOOP                       :i32 )
		( SYST_TXN_DATA :i128 :display :bytes :array [6] )
		))

(module txndata)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            ;;
;;    X.Y.Y Common columns    ;;
;;                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defcolumns
  ;; HUB block and transaction labels + transaction bit markers
  ( BLK_NUMBER      :i16          )
  ( TOTL_TXN_NUMBER :i16          )
  ( USER_TXN_NUMBER :i16          )
  ( SYSI            :binary@prove )
  ( USER            :binary@prove )
  ( SYSF            :binary@prove )
  ;; perspective flags
  ( CMPTN           :binary@prove )
  ( HUB             :binary@prove )
  ( RLP             :binary@prove )
  ;; heartbeat
  ( CT              :i4           )  ;; todo: is that enough ?
  ( CT_MAX          :i4           )
  ( GAS_CUMULATIVE  :i32          )
  )

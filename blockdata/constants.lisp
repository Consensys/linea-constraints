(module blockdata)

;; (defconst 
;;   CT_MAX_FOR_BLOCKDATA    6 ;;need to update the lookup into wcp if changed
;;   ROW_SHIFT_COINBASE      0
;;   ROW_SHIFT_TIMESTAMP     1
;;   ROW_SHIFT_NUMBER        2
;;   ROW_SHIFT_DIFFICULTY    3
;;   ROW_SHIFT_GASLIMIT      4
;;   ROW_SHIFT_CHAINID       5
;;   ROW_SHIFT_BASEFEE       6)

(defconst 
  BLOCKDATA_CT_MAX_CB       1
  BLOCKDATA_CT_MAX_TS       2
  BLOCKDATA_CT_MAX_NB       2
  BLOCKDATA_CT_MAX_DF       1
  BLOCKDATA_CT_MAX_GL       5
  BLOCKDATA_CT_MAX_ID       1
  BLOCKDATA_CT_MAX_BF       1
  )


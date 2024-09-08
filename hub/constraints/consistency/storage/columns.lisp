(module hub)

(defcolumns
  ;; storage consistency permutation related 
  ( sto_FIRST_IN_CNF :binary@prove )     ( sto_FIRST_IN_BLC :binary@prove )     ( sto_FIRST_IN_TXN :binary@prove )
  ( sto_AGAIN_IN_CNF :binary@prove )     ( sto_AGAIN_IN_BLC :binary@prove )     ( sto_AGAIN_IN_TXN :binary@prove )
  ( sto_FINAL_IN_CNF :binary@prove )     ( sto_FINAL_IN_BLC :binary@prove )     ( sto_FINAL_IN_TXN :binary@prove )
  )

(defpermutation 
  ;; permuted columns
  ;; replace scp with storage_consistency_permutation
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (
    scp_PEEK_AT_STORAGE
    scp_ADDRESS_HI
    scp_ADDRESS_LO
    scp_STORAGE_KEY_HI
    scp_STORAGE_KEY_LO
    scp_DOM_STAMP
    scp_SUB_STAMP
    ;;
    scp_ABS_TX_NUM
    scp_VALUE_ORIG_HI
    scp_VALUE_ORIG_LO
    scp_VALUE_CURR_HI
    scp_VALUE_CURR_LO
    scp_VALUE_NEXT_HI
    scp_VALUE_NEXT_LO
    ;;
    scp_WARMTH
    scp_WARMTH_NEW
    scp_DEPLOYMENT_NUMBER
    scp_DEPLOYMENT_NUMBER_INFTY
  )
  ;; original columns
  ;;;;;;;;;;;;;;;;;;;
  (
    (↓ PEEK_AT_STORAGE )
    (↓ storage/ADDRESS_HI )
    (↓ storage/ADDRESS_LO )
    (↓ storage/STORAGE_KEY_HI )
    (↓ storage/STORAGE_KEY_LO )
    (↓ DOM_STAMP )
    (↑ SUB_STAMP )
    ;;
    ABS_TX_NUM
    storage/VALUE_ORIG_HI
    storage/VALUE_ORIG_LO
    storage/VALUE_CURR_HI
    storage/VALUE_CURR_LO
    storage/VALUE_NEXT_HI
    storage/VALUE_NEXT_LO
    ;;
    storage/WARMTH
    storage/WARMTH_NEW
    storage/DEPLOYMENT_NUMBER
    storage/DEPLOYMENT_NUMBER_INFTY
  )
)

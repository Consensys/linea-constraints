(module hub)

;; account consistency permutation related 
( acc_FIRST_IN_CNF :binary@prove )     ( acc_FINAL_IN_BLC :binary@prove )     ( acc_FINAL_IN_TXN :binary@prove )
( acc_AGAIN_IN_CNF :binary@prove )     ( acc_AGAIN_IN_BLC :binary@prove )     ( acc_AGAIN_IN_TXN :binary@prove )
( acc_FINAL_IN_CNF :binary@prove )     ( acc_FINAL_IN_BLC :binary@prove )     ( acc_FINAL_IN_TXN :binary@prove )

(defpermutation
    ;; permuted columns
    ;; replace acp with account_consistency_permutation
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (
      acp_PEEK_AT_ACCOUNT
      acp_ADDRESS_HI
      acp_ADDRESS_LO
      acp_DOM_STAMP
      acp_SUB_STAMP
      ;;
      acp_TRM_FLAG
      acp_IS_PRECOMPILE
      acp_NONCE
      acp_NONCE_NEW
      acp_BALANCE
      acp_BALANCE_NEW
      acp_WARMTH
      acp_WARMTH_NEW
      acp_CODE_SIZE
      acp_CODE_SIZE_NEW
      acp_CODE_HASH_HI
      acp_CODE_HASH_LO
      acp_CODE_HASH_HI_NEW
      acp_CODE_HASH_LO_NEW
      acp_DEPLOYMENT_NUMBER
      acp_DEPLOYMENT_NUMBER_NEW
      acp_DEPLOYMENT_NUMBER_INFTY
      acp_DEPLOYMENT_STATUS
      acp_DEPLOYMENT_STATUS_NEW
      ;; acp_DEPLOYMENT_STATUS_INFTY
      acp_MARKED_FOR_SELFDESTRUCT
      acp_MARKED_FOR_SELFDESTRUCT_NEW
      acp_ABS_TX_NUM
    )
    ;; original columns
    ;;;;;;;;;;;;;;;;;;;
    (
      (↓ PEEK_AT_ACCOUNT )
      (↓ account/ADDRESS_HI )
      (↓ account/ADDRESS_LO )
      (↓ DOM_STAMP )
      (↑ SUB_STAMP )
      ;;
      account/TRM_FLAG
      account/IS_PRECOMPILE
      account/NONCE
      account/NONCE_NEW
      account/BALANCE
      account/BALANCE_NEW
      account/WARMTH
      account/WARMTH_NEW
      account/CODE_SIZE
      account/CODE_SIZE_NEW
      account/CODE_HASH_HI
      account/CODE_HASH_LO
      account/CODE_HASH_HI_NEW
      account/CODE_HASH_LO_NEW
      account/DEPLOYMENT_NUMBER
      account/DEPLOYMENT_NUMBER_NEW
      account/DEPLOYMENT_NUMBER_INFTY
      account/DEPLOYMENT_STATUS
      account/DEPLOYMENT_STATUS_NEW
      ;; account/DEPLOYMENT_STATUS_INFTY
      account/MARKED_FOR_SELFDESTRUCT
      account/MARKED_FOR_SELFDESTRUCT_NEW
      ABS_TX_NUM
    )
  )

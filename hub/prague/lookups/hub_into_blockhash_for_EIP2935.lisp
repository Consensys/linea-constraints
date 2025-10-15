(defun (hub-into-block-hash-trigger-eip2935-consistency)
  (* hub.txn/EIP_2935
     hub.PEEK_AT_TRANSACTION
     (- 1 hub.txn/SYST_TXN_DATA_5))) ;; hub.txn/SYST_TXN_DATA_5 == is-genesis-block

(defclookup
  (hub-into-blockhash :unchecked)
  ;; target columns
  (
    blockhash.macro/BLOCKHASH_ARG_HI
    blockhash.macro/BLOCKHASH_ARG_LO
    blockhash.macro/BLOCKHASH_RES_HI
    blockhash.macro/BLOCKHASH_RES_LO
  )
  ;; source selector
  (hub-into-block-hash-trigger-eip2935-consistency)
  ;; source columns
  (
    0
    hub.txn/SYST_TXN_DATA_5                 ;; previous block number (or 0 if genesis)
    hub.txn/SYST_TXN_DATA_3                 ;; previous blockhash hi (or 0 if genesis)
    hub.txn/SYST_TXN_DATA_4                 ;; previous blockhash lo (or 0 if genesis)
  ))
(defun (hub-into-block-hash-trigger-shan)
  (* hubshan.PEEK_AT_STACK (- 1 hubshan.XAHOY) hubshan.stack/BTC_FLAG [hubshan.stack/DEC_FLAG 1]))

(deflookup
  hub-into-blockhash
  ;; target columns
  (
    blockhashshan.macro/REL_BLOCK
    blockhashshan.macro/BLOCKHASH_ARG_HI
    blockhashshan.macro/BLOCKHASH_ARG_LO
    blockhashshan.macro/BLOCKHASH_RES_HI
    blockhashshan.macro/BLOCKHASH_RES_LO
  )
  ;; source columns
  (
    (*  hubshan.RELATIVE_BLOCK_NUMBER        (hub-into-block-hash-trigger-shan))
    (* [hubshan.stack/STACK_ITEM_VALUE_HI 1] (hub-into-block-hash-trigger-shan))
    (* [hubshan.stack/STACK_ITEM_VALUE_LO 1] (hub-into-block-hash-trigger-shan))
    (* [hubshan.stack/STACK_ITEM_VALUE_HI 4] (hub-into-block-hash-trigger-shan))
    (* [hubshan.stack/STACK_ITEM_VALUE_LO 4] (hub-into-block-hash-trigger-shan))
  ))



(defun (hub-into-log-info-trigger-shan)
  (* hubshan.PEEK_AT_STACK hubshan.stack/LOG_INFO_FLAG (- 1 hubshan.CT_TLI)))

(deflookup
  hub-into-loginfo
  ;; target columns
  (
    loginfoshan.ABS_TXN_NUM
    loginfoshan.ABS_LOG_NUM
    loginfoshan.INST
    loginfoshan.ADDR_HI
    loginfoshan.ADDR_LO
    [loginfoshan.TOPIC_HI 1]
    [loginfoshan.TOPIC_LO 1]
    [loginfoshan.TOPIC_HI 2]
    [loginfoshan.TOPIC_LO 2]
    [loginfoshan.TOPIC_HI 3]
    [loginfoshan.TOPIC_LO 3]
    [loginfoshan.TOPIC_HI 4]
    [loginfoshan.TOPIC_LO 4]
    loginfoshan.DATA_SIZE
  )
  ;; source columns
  (
    (* hubshan.ABSOLUTE_TRANSACTION_NUMBER (hub-into-log-info-trigger-shan))
    (* hubshan.LOG_INFO_STAMP (hub-into-log-info-trigger-shan))
    (* hubshan.stack/INSTRUCTION (hub-into-log-info-trigger-shan))
    (* (shift hubshan.context/ACCOUNT_ADDRESS_HI 2) (hub-into-log-info-trigger-shan))
    (* (shift hubshan.context/ACCOUNT_ADDRESS_LO 2) (hub-into-log-info-trigger-shan))
    (* (next [hubshan.stack/STACK_ITEM_VALUE_HI 1]) (hub-into-log-info-trigger-shan))
    (* (next [hubshan.stack/STACK_ITEM_VALUE_LO 1]) (hub-into-log-info-trigger-shan))
    (* (next [hubshan.stack/STACK_ITEM_VALUE_HI 2]) (hub-into-log-info-trigger-shan))
    (* (next [hubshan.stack/STACK_ITEM_VALUE_LO 2]) (hub-into-log-info-trigger-shan))
    (* (next [hubshan.stack/STACK_ITEM_VALUE_HI 3]) (hub-into-log-info-trigger-shan))
    (* (next [hubshan.stack/STACK_ITEM_VALUE_LO 3]) (hub-into-log-info-trigger-shan))
    (* (next [hubshan.stack/STACK_ITEM_VALUE_HI 4]) (hub-into-log-info-trigger-shan))
    (* (next [hubshan.stack/STACK_ITEM_VALUE_LO 4]) (hub-into-log-info-trigger-shan))
    (* [hubshan.stack/STACK_ITEM_VALUE_LO 2] (hub-into-log-info-trigger-shan))
  ))



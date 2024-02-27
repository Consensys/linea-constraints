(defun (hub-into-log-info-trigger) 
  (* hub.PEEK_AT_STACK
     hub.stack/LOG_INFO_FLAG
     (- 1 hub.CT_TLI)))

(deflookup hub-into-log-info
           ;; target columns
	   ( 
	     logInfo.ABS_TXN_NUM
	     logInfo.ABS_LOG_NUM
	     logInfo.INST
	     logInfo.ADDR_HI
	     logInfo.ADDR_LO
	     [logInfo.TOPIC_HI 1]
	     [logInfo.TOPIC_LO 1]
	     [logInfo.TOPIC_HI 2]
	     [logInfo.TOPIC_LO 2]
	     [logInfo.TOPIC_HI 3]
	     [logInfo.TOPIC_LO 3]
	     [logInfo.TOPIC_HI 4]
	     [logInfo.TOPIC_LO 4]
	     logInfo.DATA_SIZE
           )
           ;; source columns
	   (
	     (* hub.ABSOLUTE_TRANSACTION_NUMBER              (hub-into-log-info-trigger))
	     (* hub.LOG_INFO_STAMP                           (hub-into-log-info-trigger))
	     (* hub.stack/INSTRUCTION                        (hub-into-log-info-trigger))
	     (* (shift hub.context/ACCOUNT_ADDRESS_HI 3)     (hub-into-log-info-trigger))
	     (* (shift hub.context/ACCOUNT_ADDRESS_LO 3)     (hub-into-log-info-trigger))
	     (* (next [hub.stack/STACK_ITEM_VALUE_HI 1])     (hub-into-log-info-trigger))
	     (* (next [hub.stack/STACK_ITEM_VALUE_LO 1])     (hub-into-log-info-trigger))
	     (* (next [hub.stack/STACK_ITEM_VALUE_HI 2])     (hub-into-log-info-trigger))
	     (* (next [hub.stack/STACK_ITEM_VALUE_LO 2])     (hub-into-log-info-trigger))
	     (* (next [hub.stack/STACK_ITEM_VALUE_HI 3])     (hub-into-log-info-trigger))
	     (* (next [hub.stack/STACK_ITEM_VALUE_LO 3])     (hub-into-log-info-trigger))
	     (* (next [hub.stack/STACK_ITEM_VALUE_HI 4])     (hub-into-log-info-trigger))
	     (* (next [hub.stack/STACK_ITEM_VALUE_LO 4])     (hub-into-log-info-trigger))
	     (* [hub.stack/STACK_ITEM_VALUE_LO 2]            (hub-into-log-info-trigger))
           )
)


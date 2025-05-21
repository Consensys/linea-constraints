(defun (hub-into-wcp-activation-flag)
  (* (unexceptional-stack-row)
      hub.stack/WCP_FLAG))

(deflookup hub-into-wcp
    ;; target columns
    (
        wcp.ARGUMENT_1'1
        wcp.ARGUMENT_1'0
        wcp.ARGUMENT_2'1
        wcp.ARGUMENT_2'0
        wcp.RESULT
        wcp.INST
    )
    ;; source columns
    (
        (* [hub.stack/STACK_ITEM_VALUE_HI 1]     (hub-into-wcp-activation-flag))
        (* [hub.stack/STACK_ITEM_VALUE_LO 1]     (hub-into-wcp-activation-flag))
        (* [hub.stack/STACK_ITEM_VALUE_HI 2]     (hub-into-wcp-activation-flag))
        (* [hub.stack/STACK_ITEM_VALUE_LO 2]     (hub-into-wcp-activation-flag))
        (* [hub.stack/STACK_ITEM_VALUE_LO 4]     (hub-into-wcp-activation-flag))
        (* hub.stack/INSTRUCTION                 (hub-into-wcp-activation-flag))
    )
)

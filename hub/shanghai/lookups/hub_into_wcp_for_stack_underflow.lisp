(defun (hub-into-wcp-for-sux-activation-flag) hub.PEEK_AT_STACK)

(deflookup hub-into-wcp-for-sux
    ;; target columns
    (
        wcp.INST
        wcp.ARGUMENT_1'1
        wcp.ARGUMENT_1'0
        wcp.ARGUMENT_2'1
        wcp.ARGUMENT_2'0
        wcp.RESULT
    )
    ;; source columns
    (
        (* EVM_INST_LT         (hub-into-wcp-for-sux-activation-flag))
        0
        (* hub.HEIGHT          (hub-into-wcp-for-sux-activation-flag))
        0
        (* hub.stack/DELTA     (hub-into-wcp-for-sux-activation-flag))
        (* hub.stack/SUX       (hub-into-wcp-for-sux-activation-flag))
    )
)

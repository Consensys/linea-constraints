(defun (hub-into-wcp-for-sux-activation-flag) hubshan.PEEK_AT_STACK)

(deflookup hub-into-wcp-for-sux
    ;; target columns
    (
        wcp.INST
        wcp.ARG_1_HI
        wcp.ARG_1_LO
        wcp.ARG_2_HI
        wcp.ARG_2_LO
        wcp.RESULT
    )
    ;; source columns
    (
        (* EVM_INST_LT         (hub-into-wcp-for-sux-activation-flag))
        0
        (* hubshan.HEIGHT          (hub-into-wcp-for-sux-activation-flag))
        0
        (* hubshan.stack/DELTA     (hub-into-wcp-for-sux-activation-flag))
        (* hubshan.stack/SUX       (hub-into-wcp-for-sux-activation-flag))
    )
)

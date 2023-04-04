
(defun (binary-activation-flag) MEMORY_EXPANSION_FLAG)

(defplookup plookup-mxp-into-instruction-decoder
    ;source columns
    (
        (* [mxp.TYPE 1] (binary-activation-flag))
        (* [mxp.TYPE 2] (binary-activation-flag))
        (* [mxp.TYPE 3] (binary-activation-flag))
        (* [mxp.TYPE 4] (binary-activation-flag))
        (* [mxp.TYPE 5] (binary-activation-flag))
        (* mxp.GWORD (binary-activation-flag))
        (* mxp.GBYTE (binary-activation-flag))
    )
    ;target columns
    (
        instruction-decoder.MXP_TYPE_1
        instruction-decoder.MXP_TYPE_2
        instruction-decoder.MXP_TYPE_3
        instruction-decoder.MXP_TYPE_4
        instruction-decoder.MXP_TYPE_5
        instruction-decoder.MXP_GWORD
        instruction-decoder.MXP_GBYTE
    )
)


(module mxp)

(defplookup plookup-mxp-into-instruction-decoder
    ;source columns
    (
        [MXP_TYPE 1]
        [MXP_TYPE 2]
        [MXP_TYPE 3]
        [MXP_TYPE 4]
        [MXP_TYPE 5]
        MXP_GWORD
        MXP_GBYTE
        MXP_INST
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
        instruction-decoder.MXP_INST
    )
)

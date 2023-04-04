
(module mxp)

(defplookup plookup-mxp-into-instruction-decoder
    ;source columns
    (
        [TYPE 1]
        [TYPE 2]
        [TYPE 3]
        [TYPE 4]
        [TYPE 5]
        GWORD
        GBYTE
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

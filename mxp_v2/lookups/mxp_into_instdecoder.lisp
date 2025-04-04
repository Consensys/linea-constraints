(deflookup mxp-into-instdecoder
    ;; source columns
    (
        instdecoder.OPCODE ;; INST in the specs
        instdecoder.BILLING_PER_WORD ;; ♢GWORD in the specs
        instdecoder.BILLING_PER_BYTE ;; ♢GBYTE in the specs
        instdecoder.MXP_TYPE_1 ;; ♢TYPE_1 in the specs
        instdecoder.MXP_TYPE_2 ;; ♢TYPE_2 in the specs
        instdecoder.MXP_TYPE_3 ;; ♢TYPE_3 in the specs
        instdecoder.MXP_TYPE_4 ;; ♢TYPE_4 in the specs
        instdecoder.MXP_TYPE_5 ;; ♢TYPE_5 in the specs
    )
    ;target columns
    (
        mxp_v2.INST
        mxp_v2.GWORD
        mxp_v2.GBYTE
        [mxp_v2.MXP_TYPE 1] ;; TYPE_1 in the specs
        [mxp_v2.MXP_TYPE 2] ;; TYPE_2 in the specs
        [mxp_v2.MXP_TYPE 3] ;; TYPE_3 in the specs
        [mxp_v2.MXP_TYPE 4] ;; TYPE_4 in the specs
        [mxp_v2.MXP_TYPE 5] ;; TYPE_5 in the specs
    )
)

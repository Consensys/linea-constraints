(defplookup precinfo-into-ecdata
    (
        ;target columns
        ec_data.STAMP
        ec_data.TOTAL_PAIRINGS
    )
    (
        ;source columns
        (* prec_info.STAMP             prec_info.TRANSMITS_PAIRING_COUNT_TO_ECDATA)
        (* prec_info.PAIRING_COUNT     prec_info.TRANSMITS_PAIRING_COUNT_TO_ECDATA)
    )
)

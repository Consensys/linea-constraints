(defplookup precinfo-into-ecdata
    (
        ;target columns
        ec_data.STAMP
        ec_data.TOTAL_PAIRINGS
    )
    (
        ;source columns
        (* precompile_info.STAMP             precompile_info.TRANSMITS_PAIRING_COUNT_TO_ECDATA)
        (* precompile_info.PAIRING_COUNT     precompile_info.TRANSMITS_PAIRING_COUNT_TO_ECDATA)
    )
)

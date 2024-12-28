(module blockhash)

(defperspective    preprocessing
                   ;; selector
                   PRPRC
                   ;; instruction pre-processing fields
                   (
                    (EXO_ARG_1_HI      :i128)
                    (EXO_ARG_1_LO      :i128)
                    (EXO_ARG_2_HI      :i128)
                    (EXO_ARG_2_LO      :i128)
                    (EXO_INST          :i8)
                    (EXO_RES           :binary@prove)
                    )
                   )

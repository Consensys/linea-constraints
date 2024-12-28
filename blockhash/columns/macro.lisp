(module blockhash)

(defperspective macro
                ;; selector
                MACRO
                ;; macro-instruction fields
                (
                 (REL_BLOCK         :i8)
                 (ABS_BLOCK         :i48)
                 (BLOCKHASH_VAL_HI  :i128)
                 (BLOCKHASH_VAL_LO  :i128)
                 (BLOCKHASH_ARG_HI  :i128)
                 (BLOCKHASH_ARG_LO  :i128)
                 (BLOCKHASH_RES_HI  :i128)
                 (BLOCKHASH_RES_LO  :i128)
                 )
                )



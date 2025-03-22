(module mxp_v3)

(defperspective    macro
                ;; selector
                MACRO
                ;; macro-instruction fields
                (
                 ( INST            :byte   )
                 ( DEPLOYING       :binary )
                 ( OFFSET_1_HI     :i128   )
                 ( OFFSET_1_LO     :i128   )
                 ( SIZE_1_HI       :i128   )
                 ( SIZE_1_LO       :i128   )
                 ( OFFSET_2_HI     :i128   )
                 ( OFFSET_2_LO     :i128   )
                 ( SIZE_2_HI       :i128   )
                 ( SIZE_2_LO       :i128   )
                 ( RES             :i32    )
                 ( MXPX            :binary )
                 ( GAS_MXPX        :i64    )
                 ( MAY_TRIGGER_MMU :binary )
                 ( S1NZNOMXPX      :binary )
                 ( S2NZNOMXPX      :binary )
                 )
                )

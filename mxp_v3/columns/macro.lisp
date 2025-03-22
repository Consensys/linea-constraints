(module mxp_v3)

(defperspective macro
                ;; selector
                MACRO
                ;; macro-instruction fields
                (
                 ( INST            :byte    )
                 ( DEPLOYING       :boolean )
                 ( OFFSET_1_HI     :i128    )
                 ( OFFSET_1_LO     :i128    )
                 ( SIZE_1_HI       :i128    )
                 ( SIZE_1_LO       :i128    )
                 ( OFFSET_2_HI     :i128    )
                 ( OFFSET_2_LO     :i128    )
                 ( SIZE_2_HI       :i128    )
                 ( SIZE_2_LO       :i128    )
                 ( RES             :i32     )
                 ( MXPX            :boolean )
                 ( GAS_MXPX        :i64     )
                 ( MAY_TRIGGER_MMU :boolean )
                 ( S1NZNOMXPX      :boolean )
                 ( S2NZNOMXPX      :boolean )
                 )
                )

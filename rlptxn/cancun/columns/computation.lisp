(module rlptxn)

(defperspective cmp
                ;; selector
                CMP
                (
                 ( LIMB          :i128   )
                 ( LIMB_SIZE     :i8     )
                 ( TRM_FLAG      :binary )
                 ( RLPUTILS_FLAG :binary )
                 ( RLPUTILS_INST :i8     )
                 ( EXO_DATA_1    :i128   )
                 ( EXO_DATA_2    :i128   )
                 ( EXO_DATA_3    :binary )
                 ( EXO_DATA_4    :binary )
                 ( EXO_DATA_5    :binary )
                 ( EXO_DATA_6    :i128   )
                 ( EXO_DATA_7    :i128   )
                 ( EXO_DATA_8    :i8     )
                 ( AUX_CCC_1     :i16    )
                 ( AUX_CCC_2     :i16    )
                 ( AUX_CCC_3     :i16    )
                 ( AUX_CCC_4     :i32    )
                 ( AUX_CCC_5     :i128   )
                 ( AUX_1         :i24    )
                 ( AUX_2         :i24    )
                 ))

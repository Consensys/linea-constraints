(module rom)

(defcolumns
  ( CODE_FRAGMENT_INDEX       :i32          )
  ( CODE_FRAGMENT_INDEX_INFTY :i32          )
  ( CODE_SIZE                 :i32 :display :dec )
  ( CODE_SIZE_REACHED         :binary@prove )
  ( PROGRAM_COUNTER           :i32          )
  ;;
  ( COUNTER                   :byte         )
  ( COUNTER_MAX               :byte         )
  ;;
  ( LIMB                      :i128         )
  ( LIMB_ACC                  :i128         )
  ( LIMB_BYTE                 :byte@prove   )
  ( LIMB_INDEX                :i32          )
  ;;
  ( LIMB_SIZE                 :byte         )
  ( LIMB_SIZE_ACC             :byte         )
  ;;
  ( PUSH_COUNTER              :byte         )
  ( PUSH_COUNTER_MAX          :byte         )
  ( PUSH_CLAIMED              :binary@prove )
  ( PUSH_VALUE_ACC            :i128         )
  ( PUSH_VALUE_HI             :i128         )
  ( PUSH_VALUE_LO             :i128         )
  ( PUSH_FUNNEL_BIT           :binary@prove )
  ;;
  ( OPCODE                    :byte :display :opcode )
  ( OPCODE_IS_PUSH            :binary       )
  ( OPCODE_IS_JUMPDEST        :binary       )
  )

(defalias
  PC   PROGRAM_COUNTER
  CFI  CODE_FRAGMENT_INDEX
  CT   COUNTER
  )
  



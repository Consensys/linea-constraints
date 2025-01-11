(module blockdata)

(defcolumns
 (IOMF                :binary@prove)
 (CT_MAX              :i3)
 (CT                  :i3)
 (IS_COINBASE         :binary@prove)
 (IS_TIMESTAMP        :binary@prove)
 (IS_NUMBER           :binary@prove)
 (IS_DIFFICULTY       :binary@prove)
 (IS_GASLIMIT         :binary@prove)
 (IS_CHAINID          :binary@prove)
 (IS_BASEFEE          :binary@prove)
 (INST                :byte :display :opcode)
 (COINBASE_HI         :i32)
 (COINBASE_LO         :i128)
 (BLOCK_GAS_LIMIT     :i48)
 (BASEFEE             :i48)
 (FIRST_BLOCK_NUMBER  :i48)
 (REL_BLOCK           :i16)
 (REL_TX_NUM_MAX      :i10)
 (DATA_HI             :i128)
 (DATA_LO             :i128)
 (ARG_1_HI            :i128)
 (ARG_1_LO            :i128)
 (ARG_2_HI            :i128)
 (ARG_2_LO            :i128)
 (RES                 :i128)
 (EXO_INST            :byte :display :opcode)
 (WCP_FLAG            :binary@prove)
 (EUC_FLAG            :binary@prove)
 )

 (defalias 
  ;; TODO: update specs to make these aliases instead of shorthands
  IS_CB   IS_COINBASE
  IS_TS   IS_TIMESTAMP
  IS_NB   IS_NUMBER
  IS_DF   IS_DIFFICULTY
  IS_GL   IS_GASLIMIT
  IS_ID   IS_CHAINID
  IS_BF   IS_BASEFEE
  )

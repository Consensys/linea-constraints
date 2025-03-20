(module trm)

(defcolumns
  (STAMP          :i40)
  (FIRST          :binary)
  (RAW_ADDRESS_HI :i128)
  (RAW_ADDRESS_LO :i128)
  (TRM_ADDRESS_HI :i32)
  (IS_PRECOMPILE  :binary)
  (CT             :i4)
  (ARG_1_HI       :i128)
  (ARG_1_LO       :i128)
  (ARG_2_HI       :i128)
  (ARG_2_LO       :i128) 
  (RES            :binary)
  (INST           :byte :display :opcode)
)
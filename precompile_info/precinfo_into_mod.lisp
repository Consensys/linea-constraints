(defplookup 
  precinfo-into-mod
  (
    ;target columns
    mod.ARG_1_HI
    mod.ARG_1_LO
    mod.ARG_2_HI
    mod.ARG_2_LO
    mod.RES_HI
    mod.RES_LO
    mod.INST
  )
  (
    ;source columns
    precompile_info.EMPTY_COLUMN
    precompile_info.MOD_ARG1_LO
    precompile_info.EMPTY_COLUMN
    precompile_info.MOD_ARG2_LO
    precompile_info.EMPTY_COLUMN
    precompile_info.MOD_RES
    (if-zero precompile_info.STAMP
             0
             0x04) ;; opcode 0x04 = "DIV"

  ))


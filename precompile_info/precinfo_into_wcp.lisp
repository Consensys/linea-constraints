(defplookup 
  precinfo-into-wcp
  (
    ;target columns
    wcp.ARGUMENT_1_HI
    wcp.ARGUMENT_1_LO
    wcp.ARGUMENT_2_HI
    wcp.ARGUMENT_2_LO
    wcp.RESULT_HI
    wcp.RESULT_LO
    wcp.INST
  )
  (
    ;source columns
    0
    precompile_info.WCP_ARG1_LO
    0
    precompile_info.WCP_ARG2_LO
    0
    precompile_info.WCP_RES
    (if-zero precompile_info.STAMP
             0
             0x10) ;; opcode 0x10 = "LT"

  ))


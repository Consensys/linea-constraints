(module gas)

(defcolumns 
  (INPUTS_AND_OUTPUTS_ARE_MEANINGFUL :binary@prove)
  (FIRST :binary@prove)
  (CT :i3)
  (CT_MAX :i3)
  (GAS_ACTUAL :i32)
  (GAS_COST :i64)
  (EXCEPTIONS_AHOY :binary@prove)
  (OUT_OF_GAS_EXCEPTION :binary@prove)
  (WCP_ARG1_LO :i128)
  (WCP_ARG2_LO :i128)
  (WCP_INST :byte@prove :display :opcode)
  (WCP_RES :binary@prove))

(defalias 
  INPUTS_AND_OUTPUTS_ARE_MEANINGFUL IOMF
  EXCEPTIONS_AHOY                   XAHOY
  OUT_OF_GAS_EXCEPTION              OOGX)



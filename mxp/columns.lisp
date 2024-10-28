(module mxp)

(defcolumns 
  (STAMP :i32)
  (CN :i64)
  (CT :i5)
  (ROOB :binary@prove)
  (NOOP :binary@prove)
  (MXPX :binary@prove)
  (INST :byte :display :opcode)
  (MXP_TYPE :binary@prove :array [5])
  (GBYTE :i64)
  (GWORD :i64)
  (DEPLOYS :binary@prove)
  (OFFSET_1_LO :i128)
  (OFFSET_2_LO :i128)
  (OFFSET_1_HI :i128)
  (OFFSET_2_HI :i128)
  (SIZE_1_LO :i128)
  (SIZE_2_LO :i128)
  (SIZE_1_HI :i128)
  (SIZE_2_HI :i128)
  (MAX_OFFSET_1 :i128)
  (MAX_OFFSET_2 :i128)
  (MAX_OFFSET   :i128)
  (COMP :binary@prove)
  (BYTE :byte@prove :array [4])
  (BYTE_A :byte@prove)
  (BYTE_W :byte@prove)
  (BYTE_Q :byte@prove)
  (ACC :i136 :array [4])
  (ACC_A :i136)
  (ACC_W :i136)
  (ACC_Q :i136)
  (BYTE_QQ :byte@prove)
  (BYTE_R :byte@prove)
  (WORDS :i64)
  (WORDS_NEW :i64)
  (C_MEM :i64)
  (C_MEM_NEW :i64)
  (QUAD_COST :i64)
  (LIN_COST :i64)
  (GAS_MXP :i64)
  (EXPANDS :binary@prove)
  (MTNTOP :binary@prove)
  (SIZE_1_NONZERO_NO_MXPX :binary)
  (SIZE_2_NONZERO_NO_MXPX :binary))

  (defalias 
  S1NZNOMXPX SIZE_1_NONZERO_NO_MXPX
  S2NZNOMXPX SIZE_2_NONZERO_NO_MXPX)




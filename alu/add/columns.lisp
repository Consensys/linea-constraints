(module add)

(defcolumns 
  (STAMP :i3)
  (CT_MAX :byte)
  (CT :byte)
  (INST :byte :display :opcode)
  (ARG_1_HI :i16)
  (ARG_1_LO :i16)
  (ARG_2_HI :i16)
  (ARG_2_LO :i16)
  (RES_HI :i16)
  (RES_LO :i16)
  (BYTE_1 :byte@prove)
  (BYTE_2 :byte@prove)
  (ACC_1 :i16)
  (ACC_2 :i16)
  (OVERFLOW :binary@prove))



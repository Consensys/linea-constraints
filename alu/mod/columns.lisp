(module mod)

(defcolumns 
  (STAMP   :i32)
  (OLI     :binary@prove)
  (MLI     :binary@prove)
  (CT      :i4)
  (INST    :byte :display :opcode)
  (IS_SMOD :binary@prove)
  (IS_MOD  :binary@prove)
  (IS_SDIV :binary@prove)
  (IS_DIV  :binary@prove)
  (SIGNED  :binary@prove)
  ;
  (ARG_1_HI :i128)
  (ARG_1_LO :i128)
  (ARG_2_HI :i128)
  (ARG_2_LO :i128)
  (RES_HI   :i128)
  (RES_LO   :i128)
  ;
  (BYTE_1_3 :byte@prove)
  (ACC_1_3  :i64)
  (BYTE_1_2 :byte@prove)
  (ACC_1_2  :i64)
  (BYTE_2_3 :byte@prove)
  (ACC_2_3  :i64)
  (BYTE_2_2 :byte@prove)
  (ACC_2_2  :i64)
  ;
  (BYTE_B_3 :byte@prove)
  (ACC_B_3  :i64)
  (BYTE_B_2 :byte@prove)
  (ACC_B_2  :i64)
  (BYTE_B_1 :byte@prove)
  (ACC_B_1  :i64)
  (BYTE_B_0 :byte@prove)
  (ACC_B_0  :i64)
  ;
  (BYTE_Q_3 :byte@prove)
  (ACC_Q_3  :i64)
  (BYTE_Q_2 :byte@prove)
  (ACC_Q_2  :i64)
  (BYTE_Q_1 :byte@prove)
  (ACC_Q_1  :i64)
  (BYTE_Q_0 :byte@prove)
  (ACC_Q_0  :i64)
  ;
  (BYTE_R_3 :byte@prove)
  (ACC_R_3  :i64)
  (BYTE_R_2 :byte@prove)
  (ACC_R_2  :i64)
  (BYTE_R_1 :byte@prove)
  (ACC_R_1  :i64)
  (BYTE_R_0 :byte@prove)
  (ACC_R_0  :i64)
  ;
  (BYTE_DELTA_3 :byte@prove)
  (ACC_DELTA_3  :i64)
  (BYTE_DELTA_2 :byte@prove)
  (ACC_DELTA_2  :i64)
  (BYTE_DELTA_1 :byte@prove)
  (ACC_DELTA_1  :i64)
  (BYTE_DELTA_0 :byte@prove)
  (ACC_DELTA_0  :i64)
  ;
  (BYTE_H_2 :byte@prove)
  (ACC_H_2  :i64)
  (BYTE_H_1 :byte@prove)
  (ACC_H_1  :i64)
  (BYTE_H_0 :byte@prove)
  (ACC_H_0  :i64)
  ;
  (CMP_1 :binary@prove)
  (CMP_2 :binary@prove)
  ;
  (MSB_1 :binary@prove)
  (MSB_2 :binary@prove))



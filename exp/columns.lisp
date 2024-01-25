;; deprecated
(module exp)

(defcolumns 
  EXPNT_HI
  EXPNT_LO
  DYNCOST
  (NZEXP :binary)
  (BYTE :byte)
  ACC
  (PBIT :binary)
  PACC
  ;; deprecated stuff above
  (CMPTN :binary@prove)
  (MACRO :binary@prove)
  (PRPRC :binary@prove)
  (STAMP :i32)
  (CT :i4)
  (CT_MAX :i4)
  (IS_EXP_LOG :binary@prove)
  (IS_MODEXP_LOG :binary@prove))

(defperspective computation

  ;; selector
  CMPTN

  ;; computation-row columns
  ((PLT_BIT :binary@prove)
   (PLT_JUMP :i6)
   (RAW_BYTE :byte@prove)
   (RAW_ACC :i128)
   (TRIM_BYTE :byte@prove)
   (TRIM_ACC :i128)
   (TANZB :binary@prove)
   (TANZB_ACC :i5)
   (MSNZB :byte@prove)
   (BIT_MSNZB :binary@prove)
   (ACC_MSNZB :byte@prove)
   (MANZB :binary@prove)
   (MANZB_ACC :i4)))

(defperspective macro-instruction

  ;; selector
  MACRO

  ;; macro-instruction-row columns
  ((EXP_INST :byte@prove)
   (DATA :i128 :array [5])))

(defperspective preprocessing

  ;; selector
  PRPRC

  ;; preprocessing-row columns
  ((WCP_FLAG :binary@prove)
   (WCP_ARG_1_HI :i128)
   (WCP_ARG_1_LO :i128)
   (WCP_ARG_2_HI :i128)
   (WCP_ARG_2_LO :i128)
   (WCP_RES :binary@prove)
   (WCP_INST :byte :display :opcode)))



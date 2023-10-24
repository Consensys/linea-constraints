(module oob)

(defcolumns 
  (STAMP :i32)
  (CT :i3)
  (CT_MAX :i3)
  (DATA :array [8])
  OOB_INST
  (IS_JUMP :binary@prove)
  (IS_JUMPI :binary@prove)
  (IS_RDC :binary@prove)
  (IS_CDL :binary@prove)
  (IS_XCALL :binary@prove)
  (IS_CALL :binary@prove)
  (IS_CREATE :binary@prove)
  (IS_SSTORE :binary@prove)
  (IS_DEPLOYMENT :binary@prove)
  (IS_ECRECOVER :binary@prove)
  (IS_SHA2 :binary@prove)
  (IS_RIPEMD :binary@prove)
  (IS_IDENTITY :binary@prove)
  (IS_ECADD :binary@prove)
  (IS_ECMUL :binary@prove)
  (IS_ECPAIRING :binary@prove)
  (IS_BLAKE2F_cds :binary@prove)
  (IS_BLAKE2F_params :binary@prove)
  (IS_MODEXP_cds :binary@prove)
  (IS_MODEXP_xbs :binary@prove)
  (IS_MODEXP_lead :binary@prove)
  (IS_MODEXP_pricing :binary@prove)
  (IS_MODEXP_extract :binary@prove)
  (WCP_FLAG :binary@prove)
  (ADD_FLAG :binary@prove)
  (MOD_FLAG :binary@prove)
  (OUTGOING_INST :byte :display :opcode)
  (OUTGOING_DATA :array [4])
  OUTGOING_RES_LO)
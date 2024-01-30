(module oob)

(defcolumns 
  STAMP
  CT
  CT_MAX
  (DATA :array [8])
  INST

  (IS_JUMP :binary)
  (IS_JUMPI :binary)
  (IS_RDC :binary)
  (IS_CDL :binary)
  (IS_XCALL :binary)
  (IS_CALL :binary)
  (IS_CREATE :binary)
  (IS_SSTORE :binary)
  (IS_RETURN :binary)

  (PRC_ECRECOVER :binary)
  (PRC_SHA2 :binary)
  (PRC_RIPEMD :binary)
  (PRC_IDENTITY :binary)
  (PRC_ECADD :binary)
  (PRC_ECMUL :binary)
  (PRC_ECPAIRING :binary)
  (PRC_BLAKE2F_cds :binary)
  (PRC_BLAKE2F_params :binary)
  (PRC_MODEXP_cds :binary)
  (PRC_MODEXP_base :binary)
  (PRC_MODEXP_exponent :binary)
  (PRC_MODEXP_modulus :binary)
  (PRC_MODEXP_pricing :binary)

  (WCP_FLAG :binary)
  (ADD_FLAG :binary)
  (MOD_FLAG :binary)
  (OUTGOING_INST :byte :display :opcode)
  (OUTGOING_DATA :array [4])
  OUTGOING_RES_LO
  )



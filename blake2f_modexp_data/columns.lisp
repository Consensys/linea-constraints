(module blake2f_modexp_data)

(defcolumns 
  (STAMP :byte)
  (ID :i48)
  (PHASE :byte)
  (INDEX :byte :display :dec)
  (INDEX_MAX :byte :display :dec)
  (LIMB :i16 :display :bytes)
  (DELTA_BYTE :byte)
  (IS_MODEXP_BASE :binary)
  (IS_MODEXP_EXPONENT :binary)
  (IS_MODEXP_MODULUS :binary)
  (IS_MODEXP_RESULT :binary)
  (IS_BLAKE_DATA :binary)
  (IS_BLAKE_PARAMS :binary)
  (IS_BLAKE_RESULT :binary))


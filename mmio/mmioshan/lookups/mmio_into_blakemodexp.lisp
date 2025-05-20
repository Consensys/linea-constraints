(deflookup
  mmio-into-blake2fmodexpdata
  ;reference columns
  (
    blake2fmodexpdata.ID
    blake2fmodexpdata.PHASE
    blake2fmodexpdata.INDEX
    blake2fmodexpdata.LIMB
  )
  ;source columns
  (
    (* mmioshan.EXO_IS_BLAKEMODEXP mmioshan.EXO_ID)
    (* mmioshan.EXO_IS_BLAKEMODEXP mmioshan.PHASE)
    (* mmioshan.EXO_IS_BLAKEMODEXP mmioshan.INDEX_X)
    (* mmioshan.EXO_IS_BLAKEMODEXP mmioshan.LIMB)
  ))



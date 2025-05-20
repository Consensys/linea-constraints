(deflookup
  mmio-into-kec
  ;reference columns
  (
    shakiradata.ID
    shakiradata.PHASE
    shakiradata.INDEX
    shakiradata.LIMB
    shakiradata.nBYTES
    shakiradata.TOTAL_SIZE
  )
  ;source columns
  (
    (* mmioshan.EXO_IS_KEC mmioshan.KEC_ID)
    (* mmioshan.EXO_IS_KEC PHASE_KECCAK_DATA)
    (* mmioshan.EXO_IS_KEC mmioshan.INDEX_X)
    (* mmioshan.EXO_IS_KEC mmioshan.LIMB)
    (* mmioshan.EXO_IS_KEC mmioshan.SIZE)
    (* mmioshan.EXO_IS_KEC mmioshan.TOTAL_SIZE)
  ))



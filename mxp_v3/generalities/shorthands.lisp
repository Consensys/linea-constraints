(module mxp_v3)

(defun  (mxp-perspective-sum)
  (+    DECDR
	MACRO
	SCNRI
	CMPTN))

(defun  (mxp-perspective-wght-sum)
  (+    (*   1   DECDR )
	(*   2   MACRO )
	(*   3   SCNRI )
	(*   4   CMPTN )))

(defun  (mxp-ct-max-sum)
  (+    (*   CT_MAX_MSIZE    MSIZE                     )
	(*   CT_MAX_TRIV     TRIVIAL                   )
	(*   CT_MAX_MXPX     MXPX                      )
	(*   CT_MAX_UPDT_W   STATE_UPDATE_WORD_PRICING )
	(*   CT_MAX_UPDT_B   STATE_UPDATE_BYTE_PRICING )
	))


(defconst
  nROWS_MSIZE    1
  nROWS_TRIV     2
  nROWS_MXPX     6
  nROWS_UPDT_W  10
  nROWS_UPDT_B  11

  CT_MAX_MSIZE    (-  nROWS_MSIZE   1)
  CT_MAX_TRIV     (-  nROWS_TRIV    1)
  CT_MAX_MXPX     (-  nROWS_MXPX    1)
  CT_MAX_UPDT_W   (-  nROWS_UPDT_W  1)
  CT_MAX_UPDT_B   (-  nROWS_UPDT_B  1)
  )

(defun
  (mxp-to-wcp-selector)
  (* mxp_v3.COMPUTATION mxp_v3.computation/WCP_FLAG)
  )

(deflookup
  mxp-into-wcp
  ;reference columns
  (
    wcp.INST
    wcp.ARGUMENT_1_HI
    wcp.ARGUMENT_1_LO
    wcp.ARGUMENT_2_HI
    wcp.ARGUMENT_2_LO
    wcp.RESULT
  )
  ;source columns
  (
    (* mxp_v3.computation/EXO_INST (mxp-to-wcp-selector))
    (* mxp_v3.computation/ARG_1_HI (mxp-to-wcp-selector))
    (* mxp_v3.computation/ARG_1_LO (mxp-to-wcp-selector))
    (* mxp_v3.computation/ARG_2_HI (mxp-to-wcp-selector))
    (* mxp_v3.computation/ARG_2_LO (mxp-to-wcp-selector))
    (* mxp_v3.computation/RES_A    (mxp-to-wcp-selector))
  ))

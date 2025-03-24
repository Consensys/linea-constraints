(defun
  (mxp-to-euc-selector)
  (* mxp_v3.COMPUTATION mxp_v3.computation/EUC_FLAG)
  )

(deflookup
  mxp-into-euc
  ;reference columns
  (
    euc.DIVIDEND
    euc.DIVISOR
    euc.QUOTIENT
    euc.CEIL
    euc.DONE
  )
  ;source columns
  (
    (* mxp_v3.computation/ARG_1_LO (mxp-to-euc-selector))
    (* mxp_v3.computation/ARG_2_LO (mxp-to-euc-selector))
    (* mxp_v3.computation/RES_A    (mxp-to-euc-selector))
    (* mxp_v3.computation/RES_B    (mxp-to-euc-selector))
    (mxp-to-euc-selector)
  ))

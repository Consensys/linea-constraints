(defun
  (mxp-to-euc-selector)
  (* mxpcan.COMPUTATION mxpcan.computation/EUC_FLAG)
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
    (* mxpcan.computation/ARG_1_LO (mxp-to-euc-selector))
    (* mxpcan.computation/ARG_2_LO (mxp-to-euc-selector))
    (* mxpcan.computation/RES_A    (mxp-to-euc-selector))
    (* mxpcan.computation/RES_B    (mxp-to-euc-selector))
    (mxp-to-euc-selector)
  ))

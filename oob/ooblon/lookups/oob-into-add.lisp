(defun (mxp-into-add-flag)
  ooblon.ADD_FLAG)

(deflookup
  oob-into-add
  ;source columns
  (
    add.ARG_1_HI
    add.ARG_1_LO
    add.ARG_2_HI
    add.ARG_2_LO
    add.RES_HI
    add.RES_LO
    add.INST
  )
  ;target columns
  (
    (* [ooblon.OUTGOING_DATA 1] (mxp-into-add-flag))
    (* [ooblon.OUTGOING_DATA 2] (mxp-into-add-flag))
    (* [ooblon.OUTGOING_DATA 3] (mxp-into-add-flag))
    (* [ooblon.OUTGOING_DATA 4] (mxp-into-add-flag))
    (* (next [ooblon.OUTGOING_DATA 1]) (mxp-into-add-flag))
    (* (next [ooblon.OUTGOING_DATA 2]) (mxp-into-add-flag))
    (* ooblon.OUTGOING_INST (mxp-into-add-flag))
  ))



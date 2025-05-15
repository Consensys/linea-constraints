(defun (oob-into-add-activation-flag-shan)
  oobshan.ADD_FLAG)

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
    (* [oobshan.OUTGOING_DATA 1] (oob-into-add-activation-flag-shan))
    (* [oobshan.OUTGOING_DATA 2] (oob-into-add-activation-flag-shan))
    (* [oobshan.OUTGOING_DATA 3] (oob-into-add-activation-flag-shan))
    (* [oobshan.OUTGOING_DATA 4] (oob-into-add-activation-flag-shan))
    (* (next [oobshan.OUTGOING_DATA 1]) (oob-into-add-activation-flag-shan))
    (* (next [oobshan.OUTGOING_DATA 2]) (oob-into-add-activation-flag-shan))
    (* oobshan.OUTGOING_INST (oob-into-add-activation-flag-shan))
  ))



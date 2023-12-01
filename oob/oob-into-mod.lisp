(defun (add-activation-flag)
  oob.MOD_FLAG)

(deflookup 
  oob-into-mod
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
    (* [oob.OUTGOING_DATA 1] (add-activation-flag))
    (* [oob.OUTGOING_DATA 2] (add-activation-flag))
    (* [oob.OUTGOING_DATA 3] (add-activation-flag))
    (* [oob.OUTGOING_DATA 4] (add-activation-flag))
    (* 0 (add-activation-flag))
    (* oob.OUTGOING_RES_LO (add-activation-flag))
    (* oob.OUTGOING_INST (add-activation-flag))
  ))


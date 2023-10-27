(defun (add-activation-flag)
  ADD_FLAG)

(defplookup 
  oob-into-add
  ;source columns
  (
    (* [oob.OUTGOING_DATA 1] (add-activation-flag))
    (* [oob.OUTGOING_DATA 2] (add-activation-flag))
    (* [oob.OUTGOING_DATA 3] (add-activation-flag))
    (* [oob.OUTGOING_DATA 4] (add-activation-flag))
    (* (next [oob.OUTGOING_DATA 1]) (add-activation-flag))
    (* (next [oob.OUTGOING_DATA 2]) (add-activation-flag))
    (* oob.OUTGOING_INST (add-activation-flag))
  )
  ;target columns
  (
    add.ARG_1_HI
    add.ARG_1_LO
    add.ARG_2_HI
    add.ARG_2_LO
    add.RES_HI
    add.RES_LO
    add.INST
  ))



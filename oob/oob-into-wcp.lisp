(defun (wcp-activation-flag)
  WCP)

(defplookup 
  oob-into-wcp
  ;source columns
  (
    (* [oob.OUTGOING_DATA 1] (wcp-activation-flag))
    (* [oob.OUTGOING_DATA 2] (wcp-activation-flag))
    (* [oob.OUTGOING_DATA 3] (wcp-activation-flag))
    (* [oob.OUTGOING_DATA 4] (wcp-activation-flag))
    (* oob.OUTGOING_RES_LO (wcp-activation-flag))
    (* oob.OUTGOING_INST (wcp-activation-flag))
  )
  ;target columns
  (
    wcp.ARG_1_HI
    wcp.ARG_1_LO
    wcp.ARG_2_HI
    wcp.ARG_2_LO
    wcp.RES_LO
    wcp.INST
  ))

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



(defun (oob-into-wcp-activation-flag)
  oob.WCP_FLAG)

(defclookup
  oob-into-wcp
  ;; target columns
  (
    wcp.ARG_1
    wcp.ARG_2
    wcp.RES
    wcp.INST
  )
  ;; source selector
  (oob-into-wcp-activation-flag)
  ;; source columns
  (
    (:: [oob.OUTGOING_DATA 1] [oob.OUTGOING_DATA 2])
    (:: [oob.OUTGOING_DATA 3] [oob.OUTGOING_DATA 4])
    (i1 oob.OUTGOING_RES_LO)
    (i8 oob.OUTGOING_INST)
  ))



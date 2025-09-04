(defun (exp-into-wcp-activation-flag) (* exp.PRPRC exp.preprocessing/WCP_FLAG))

(defclookup
  exp-into-wcp
  ;; target columns
  (
    wcp.ARG_1
    wcp.ARG_2
    wcp.RES
    wcp.INST
  )
  ;; source selector
  (exp-into-wcp-activation-flag)
  ;; source columns
  (
    (:: exp.preprocessing/WCP_ARG_1_HI exp.preprocessing/WCP_ARG_1_LO)
    (:: exp.preprocessing/WCP_ARG_2_HI exp.preprocessing/WCP_ARG_2_LO)
    exp.preprocessing/WCP_RES
    exp.preprocessing/WCP_INST
  ))



(defun (exp-into-wcp-activation-flag) (* exp.PRPRC exp.preprocessing/WCP_FLAG))

(deflookup
  exp-into-wcp
  ;; target columns
  (
    wcp.ARGUMENT_1'1
    wcp.ARGUMENT_1'0
    wcp.ARGUMENT_2'1
    wcp.ARGUMENT_2'0
    wcp.RESULT
    wcp.INST
  )
  ;; source columns
  (
    (*   exp.preprocessing/WCP_ARG_1_HI   (exp-into-wcp-activation-flag))
    (*   exp.preprocessing/WCP_ARG_1_LO   (exp-into-wcp-activation-flag))
    (*   exp.preprocessing/WCP_ARG_2_HI   (exp-into-wcp-activation-flag))
    (*   exp.preprocessing/WCP_ARG_2_LO   (exp-into-wcp-activation-flag))
    (*   exp.preprocessing/WCP_RES        (exp-into-wcp-activation-flag))
    (*   exp.preprocessing/WCP_INST       (exp-into-wcp-activation-flag))
  ))



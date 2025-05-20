(defun (hub-into-wcp-for-sox-activation-flag-shan)
  (* hubshan.PEEK_AT_STACK (- 1 hubshan.stack/SUX)))

(defun (projected-height-shan)
  (- (+ hubshan.HEIGHT hubshan.stack/ALPHA) hubshan.stack/DELTA))

(deflookup
  hub-into-wcp-for-sox
  ;; target columns
  (
    wcp.INST
    wcp.ARG_1_HI
    wcp.ARG_1_LO
    wcp.ARG_2_HI
    wcp.ARG_2_LO
    wcp.RESULT
  )
  ;; source columns
  (
    (* EVM_INST_GT (hub-into-wcp-for-sox-activation-flag-shan))
    0
    (* (projected-height-shan) (hub-into-wcp-for-sox-activation-flag-shan))
    0
    (* 1024 (hub-into-wcp-for-sox-activation-flag-shan))
    (* hubshan.stack/SOX (hub-into-wcp-for-sox-activation-flag-shan))
  ))



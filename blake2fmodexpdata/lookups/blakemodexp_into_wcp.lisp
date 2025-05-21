(defun (blake2fmodexpdata-into-wcp-oob-into-wcp-activation-flag)
  (force-bin (* (~ blake2fmodexpdata.STAMP)
                (- blake2fmodexpdata.STAMP (prev blake2fmodexpdata.STAMP)))))

(deflookup
  blake2fmodexpdata-into-wcp
  ; target colums (in WCP)
  (
    wcp.ARGUMENT_1'1
    wcp.ARGUMENT_1'0
    wcp.ARGUMENT_2'1
    wcp.ARGUMENT_2'0
    wcp.RESULT
    wcp.INST
  )
  ; source columns
  (
    0
    (* (blake2fmodexpdata-into-wcp-oob-into-wcp-activation-flag) (prev blake2fmodexpdata.ID))
    0
    (* (blake2fmodexpdata-into-wcp-oob-into-wcp-activation-flag) blake2fmodexpdata.ID)
    (* (blake2fmodexpdata-into-wcp-oob-into-wcp-activation-flag) 1)
    (* (blake2fmodexpdata-into-wcp-oob-into-wcp-activation-flag) EVM_INST_LT)
  ))



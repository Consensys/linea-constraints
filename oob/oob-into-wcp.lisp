(defun (wcp-activation-flag)
  oob.WCP_FLAG)

(deflookup 
  oob-into-wcp
  (
    wcp.ARGUMENT_1_HI
    wcp.ARGUMENT_1_LO
    wcp.ARGUMENT_2_HI
    wcp.ARGUMENT_2_LO
    wcp.RESULT_LO
    wcp.INST
  )
  (
    (* [oob.OUTGOING_DATA 1] (wcp-activation-flag))
    (* [oob.OUTGOING_DATA 2] (wcp-activation-flag))
    (* [oob.OUTGOING_DATA 3] (wcp-activation-flag))
    (* [oob.OUTGOING_DATA 4] (wcp-activation-flag))
    (* oob.OUTGOING_RES_LO (wcp-activation-flag))
    (* oob.OUTGOING_INST (wcp-activation-flag))
  ))

; For JUMPI row i
; 0 = pc_new_hi = oob.OUTGOING_DATA 1 = wcp.ARGUMENT_1_HI = 0x0
; 0x2d = pc_new_lo = oob.OUTGOING_DATA 2 = wcp.ARGUMENT_1_LO = 0xd482933a7fc9680
; 0x0 = oob.OUTGOING_DATA 3 = wcp.ARGUMENT_2_HI = 0
; 0x343 = codesize = oob.OUTGOING_DATA 4 = wcp.ARGUMENT_2_LO = 0x98967fff676980
; 1 = pc_new < codesize =oob.OUTGOING_RES_LO = wcp.RESULT_LO = 0x0
; LT = oob.OUTGOING_INST = wcp.INST = 0x10



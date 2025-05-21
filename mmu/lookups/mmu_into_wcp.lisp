(defun (mmu-to-wcp-selector)
  (* mmu.PRPRC mmu.prprc/WCP_FLAG))

(deflookup
  mmu-into-wcp
  ;reference columns
  (
    wcp.ARGUMENT_1'1
    wcp.ARGUMENT_1'0
    wcp.ARGUMENT_2'1
    wcp.ARGUMENT_2'0
    wcp.RESULT
    wcp.INST
  )
  ;source columns
  (
    (* mmu.prprc/WCP_ARG_1_HI (mmu-to-wcp-selector))
    (* mmu.prprc/WCP_ARG_1_LO (mmu-to-wcp-selector))
    0
    (* mmu.prprc/WCP_ARG_2_LO (mmu-to-wcp-selector))
    (* mmu.prprc/WCP_RES (mmu-to-wcp-selector))
    (* mmu.prprc/WCP_INST (mmu-to-wcp-selector))
  ))



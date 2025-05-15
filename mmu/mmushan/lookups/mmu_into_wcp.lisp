(defun (mmu-to-wcp-selector-shan)
  (* mmushan.PRPRC mmushan.prprc/WCP_FLAG))

(deflookup
  mmu-into-wcp
  ;reference columns
  (
    wcp.ARG_1_HI
    wcp.ARG_1_LO
    wcp.ARG_2_HI
    wcp.ARG_2_LO
    wcp.RES
    wcp.INST
  )
  ;source columns
  (
    (* mmushan.prprc/WCP_ARG_1_HI (mmu-to-wcp-selector-shan))
    (* mmushan.prprc/WCP_ARG_1_LO (mmu-to-wcp-selector-shan))
    0
    (* mmushan.prprc/WCP_ARG_2_LO (mmu-to-wcp-selector-shan))
    (* mmushan.prprc/WCP_RES (mmu-to-wcp-selector-shan))
    (* mmushan.prprc/WCP_INST (mmu-to-wcp-selector-shan))
  ))



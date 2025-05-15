(defun (blockdata-into-wcp-selector-shan)
  blockdatashan.WCP_FLAG)

(deflookup 
  blockdata-into-wcp
  ;; target columns
  (
    wcp.ARGUMENT_1_HI
    wcp.ARGUMENT_1_LO
    wcp.ARGUMENT_2_HI
    wcp.ARGUMENT_2_LO
    wcp.RESULT
    wcp.INST
  )
  ;; source columns
  (
    (* blockdatashan.ARG_1_HI (blockdata-into-wcp-selector-shan))
    (* blockdatashan.ARG_1_LO (blockdata-into-wcp-selector-shan))
    (* blockdatashan.ARG_2_HI (blockdata-into-wcp-selector-shan))
    (* blockdatashan.ARG_2_LO (blockdata-into-wcp-selector-shan))
    (* blockdatashan.RES      (blockdata-into-wcp-selector-shan))
    (* blockdatashan.EXO_INST (blockdata-into-wcp-selector-shan))
  ))


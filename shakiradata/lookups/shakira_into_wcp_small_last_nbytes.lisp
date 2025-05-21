(deflookup
  shakiradata-into-wcp-small-last-nbytes
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
    (* (is-final-data-row) shakiradata.nBYTES)
    0
    (* (is-final-data-row) LLARGE)
    (* (is-final-data-row) 1)
    (* (is-final-data-row) WCP_INST_LEQ)
  ))



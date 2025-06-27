(defun (is-result)
  (force-bin (+ ;; shakiradata.IS_KECCAK_DATA
                shakiradata.IS_KECCAK_RESULT
                ;; shakiradata.IS_SHA2_DATA
                shakiradata.IS_SHA2_RESULT
                ;; shakiradata.IS_RIPEMD_DATA
                shakiradata.IS_RIPEMD_RESULT)))

(defun (is-final-data-row)
  (force-bin (* (is-data) (next (is-result)))))

(deflookup
  shakiradata-into-wcp-nonzero-last-nbytes
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
    0
    (* (is-final-data-row) 1)
    (* (is-final-data-row) EVM_INST_GT)
  ))



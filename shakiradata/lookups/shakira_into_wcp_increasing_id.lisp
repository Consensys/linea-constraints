(defun (is-data)
  (force-bin (+ shakiradata.IS_KECCAK_DATA
                ;; IS_KECCAK_RESULT
                shakiradata.IS_SHA2_DATA
                ;; IS_SHA2_RESULT
                shakiradata.IS_RIPEMD_DATA
                ;; IS_RIPEMD_RESULT
                )))

(defun (is-first-data-row)
  (force-bin (* (is-data)
                (- 1 (prev (is-data))))))

(deflookup
  shakiradata-into-wcp-increasing-id
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
    (* (is-first-data-row) (prev shakiradata.ID))
    0
    (* (is-first-data-row) shakiradata.ID)
    (* (is-first-data-row) 1)
    (* (is-first-data-row) EVM_INST_LT)
  ))

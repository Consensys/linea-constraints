(defun   (blockhash-into-wcp-selector)   blockhash.PRPRC) ;; ""

(deflookup
  blockhash-into-wcp-lex
  ; target columns
  (
   wcp.ARGUMENT_1'1
   wcp.ARGUMENT_1'0
   wcp.ARGUMENT_2'1
   wcp.ARGUMENT_2'0
   wcp.INST
   wcp.RESULT
   )
  ; source columns
  (
   (*   blockhash.preprocessing/EXO_ARG_1_HI   (blockhash-into-wcp-selector))
   (*   blockhash.preprocessing/EXO_ARG_1_LO   (blockhash-into-wcp-selector))
   (*   blockhash.preprocessing/EXO_ARG_2_HI   (blockhash-into-wcp-selector))
   (*   blockhash.preprocessing/EXO_ARG_2_LO   (blockhash-into-wcp-selector))
   (*   blockhash.preprocessing/EXO_INST       (blockhash-into-wcp-selector))
   (*   blockhash.preprocessing/EXO_RES        (blockhash-into-wcp-selector))
   )
  )



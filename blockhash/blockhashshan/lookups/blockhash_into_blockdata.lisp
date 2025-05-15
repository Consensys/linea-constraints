(defun   (blockhash-into-blockdata-selector-shan)   blockhashshan.MACRO) ;; ""

(deflookup
  blockhash-into-blockdata
  ; target columns
  (
   blockdatashan.REL_BLOCK
   blockdatashan.DATA_LO
   blockdatashan.INST
   )
  ; source columns
  (
   (* (blockhash-into-blockdata-selector-shan)   blockhashshan.macro/REL_BLOCK)
   (* (blockhash-into-blockdata-selector-shan)   blockhashshan.macro/ABS_BLOCK)
   (* (blockhash-into-blockdata-selector-shan)   EVM_INST_NUMBER)
   )
  )

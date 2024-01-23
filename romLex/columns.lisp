(module romLex)

(defcolumns 
  (CODE_FRAGMENT_INDEX :i4)
  (CODE_FRAGMENT_INDEX_INFTY :i4)
  (CODE_SIZE :i4)
  (ADDR_HI :i4)
  (ADDR_LO :i16)
  (DEP_NUMBER :i2)
  (DEP_STATUS :binary@prove)
  (COMMIT_TO_STATE :binary@prove)
  (READ_FROM_STATE :binary@prove))

(defalias 
  CFI CODE_FRAGMENT_INDEX)



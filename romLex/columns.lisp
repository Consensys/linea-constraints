(module romLex)

(defcolumns 
  CODE_FRAGMENT_INDEX
  CODE_FRAGMENT_INDEX_INFTY
  ADDR_HI
  ADDR_LO
  DEP_NUMBER
  (DEP_STATUS :boolean)
  (IS_INIT :boolean)
  (COMMIT_TO_STATE :boolean)
  (READ_FROM_STATE :boolean))

(defalias 
  CFI CODE_FRAGMENT_INDEX)



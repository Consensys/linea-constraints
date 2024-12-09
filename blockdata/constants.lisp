(module blockdata)

(defconst
  ;;
  ;; CT MAX FOR BLOCKDATA COLUMNS
  ;;
  CT_MAX_CB       1
  CT_MAX_TS       2
  CT_MAX_NB       2
  CT_MAX_DF       1
  CT_MAX_GL       5
  CT_MAX_ID       1
  CT_MAX_BF       1
  CT_MAX_DEPTH    (+ CT_MAX_CB CT_MAX_TS CT_MAX_NB CT_MAX_DF CT_MAX_GL CT_MAX_ID CT_MAX_BF)
)


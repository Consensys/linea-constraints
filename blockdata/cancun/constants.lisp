(module blockdata)

(defconst
  ;;
  ;; CT MAX FOR BLOCKDATA COLUMNS
  ;;
  nROWS_CB       1
  nROWS_TS       2
  nROWS_NB       2
  nROWS_PV       1
  nROWS_GL       5
  nROWS_ID       1
  nROWS_BF       1
  nROWS_BL       1
  nROWS_DEPTH    (+ nROWS_CB nROWS_TS nROWS_NB nROWS_PV nROWS_GL nROWS_ID nROWS_BF nROWS_BL)
)


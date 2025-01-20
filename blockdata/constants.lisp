(module blockdata)

(defconst
  ;;
  ;; CT MAX FOR BLOCKDATA COLUMNS
  ;;
  nROWS_CB       1
  nROWS_TS       2
  nROWS_NB       2
  nROWS_DF       1
  nROWS_GL       5
  nROWS_ID       1
  nROWS_BF       1
  nROWS_DEPTH    (+ nROWS_CB nROWS_TS nROWS_NB nROWS_DF nROWS_GL nROWS_ID nROWS_BF)
)

(defconst
  ETHEREUM_GAS_LIMIT_MINIMUM                5000
  ETHEREUM_GAS_LIMIT_MAXIMUM                0xffffffffffffffff ;; maxUint64
  LINEA_GAS_LIMIT_MINIMUM                   61000000
  LINEA_GAS_LIMIT_MAXIMUM                   2000000000
)


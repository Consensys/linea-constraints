(module rlputils)

(defclookup
  rlp-utils-into-wcp
  ; target columns
  (
    wcp.ARGUMENT_1_HI
    wcp.ARGUMENT_1_LO
    wcp.ARGUMENT_2_HI
    wcp.ARGUMENT_2_LO
    wcp.RESULT
    wcp.INST
    )
  ; source selector
  rlputils.COMPT
  ; source columns
  (
    compt/ARG_1_HI
    compt/ARG_1_LO
    0
    compt/ARG_2_LO
    compt/RES
    compt/INST
    ))

(defcall
  ;; return(s)
  (compt/WCP_CT_MAX)
  ;; function
  maxlog
  ;; argument(s)
  (compt/INST compt/ARG_1_HI compt/ARG_1_LO compt/ARG_2_LO)
  ;; source selector
  (!= 0 COMPT))

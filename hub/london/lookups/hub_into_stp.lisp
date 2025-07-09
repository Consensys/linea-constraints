(defun (hub-into-stp-trigger)
  (* hub.PEEK_AT_MISCELLANEOUS hub.misc/STP_FLAG))

(defclookup
  hub-into-stp
  ;; target columns
  (
    stp.INSTRUCTION
    stp.GAS_HI
    stp.GAS_LO
    stp.VAL_HI
    stp.VAL_LO
    stp.EXISTS
    stp.WARM
    stp.OUT_OF_GAS_EXCEPTION
    stp.GAS_ACTUAL
    stp.GAS_UPFRONT
    stp.GAS_MXP
    stp.GAS_OUT_OF_POCKET
    stp.GAS_STIPEND
  )
  ;; source selector
  (hub-into-stp-trigger)
  ;; source columns
  (
    hub.misc/STP_INSTRUCTION
    hub.misc/STP_GAS_HI
    hub.misc/STP_GAS_LO
    hub.misc/STP_VALUE_HI
    hub.misc/STP_VALUE_LO
    hub.misc/STP_EXISTS
    hub.misc/STP_WARMTH
    hub.misc/STP_OOGX
    hub.GAS_ACTUAL
    hub.misc/STP_GAS_UPFRONT_GAS_COST
    hub.misc/STP_GAS_MXP
    hub.misc/STP_GAS_PAID_OUT_OF_POCKET
    hub.misc/STP_GAS_STIPEND
  )
  )



(defun (hub-into-mxp-trigger)
  (* hub.PEEK_AT_MISCELLANEOUS hub.misc/MXP_FLAG))

(deflookup
  hub-into-mxp
  ;; target columns
  (
    mxplon.STAMP
    mxplon.CN
    mxplon.INST
    mxplon.MXPX
    mxplon.DEPLOYS
    mxplon.OFFSET_1_HI
    mxplon.OFFSET_1_LO
    mxplon.OFFSET_2_HI
    mxplon.OFFSET_2_LO
    mxplon.SIZE_1_HI
    mxplon.SIZE_1_LO
    mxplon.SIZE_2_HI
    mxplon.SIZE_2_LO
    mxplon.WORDS
    mxplon.GAS_MXP
    mxplon.MTNTOP
    mxplon.SIZE_1_NONZERO_NO_MXPX
    mxplon.SIZE_2_NONZERO_NO_MXPX
  )
  ;; source columns
  (
    (* hub.MXP_STAMP                       (hub-into-mxp-trigger))
    (* hub.CONTEXT_NUMBER                  (hub-into-mxp-trigger))
    (* hub.misc/MXP_INST                   (hub-into-mxp-trigger))
    (* hub.misc/MXP_MXPX                   (hub-into-mxp-trigger))
    (* hub.misc/MXP_DEPLOYS                (hub-into-mxp-trigger))
    (* hub.misc/MXP_OFFSET_1_HI            (hub-into-mxp-trigger))
    (* hub.misc/MXP_OFFSET_1_LO            (hub-into-mxp-trigger))
    (* hub.misc/MXP_OFFSET_2_HI            (hub-into-mxp-trigger))
    (* hub.misc/MXP_OFFSET_2_LO            (hub-into-mxp-trigger))
    (* hub.misc/MXP_SIZE_1_HI              (hub-into-mxp-trigger))
    (* hub.misc/MXP_SIZE_1_LO              (hub-into-mxp-trigger))
    (* hub.misc/MXP_SIZE_2_HI              (hub-into-mxp-trigger))
    (* hub.misc/MXP_SIZE_2_LO              (hub-into-mxp-trigger))
    (* hub.misc/MXP_WORDS                  (hub-into-mxp-trigger))
    (* hub.misc/MXP_GAS_MXP                (hub-into-mxp-trigger))
    (* hub.misc/MXP_MTNTOP                 (hub-into-mxp-trigger))
    (* hub.misc/MXP_SIZE_1_NONZERO_NO_MXPX (hub-into-mxp-trigger))
    (* hub.misc/MXP_SIZE_2_NONZERO_NO_MXPX (hub-into-mxp-trigger))
  ))

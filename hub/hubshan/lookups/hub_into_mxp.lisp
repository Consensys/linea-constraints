(defun (hub-into-mxp-trigger)
  (* hubshan.PEEK_AT_MISCELLANEOUS hubshan.misc/MXP_FLAG))

(deflookup
  hub-into-mxp
  ;; target columns
  (
    mxp.STAMP
    mxp.CN
    mxp.INST
    mxp.MXPX
    mxp.DEPLOYS
    mxp.OFFSET_1_HI
    mxp.OFFSET_1_LO
    mxp.OFFSET_2_HI
    mxp.OFFSET_2_LO
    mxp.SIZE_1_HI
    mxp.SIZE_1_LO
    mxp.SIZE_2_HI
    mxp.SIZE_2_LO
    mxp.WORDS
    mxp.GAS_MXP
    mxp.MTNTOP
    mxp.SIZE_1_NONZERO_NO_MXPX
    mxp.SIZE_2_NONZERO_NO_MXPX
  )
  ;; source columns
  (
    (* hubshan.MXP_STAMP                       (hub-into-mxp-trigger))
    (* hubshan.CONTEXT_NUMBER                  (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_INST                   (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_MXPX                   (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_DEPLOYS                (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_OFFSET_1_HI            (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_OFFSET_1_LO            (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_OFFSET_2_HI            (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_OFFSET_2_LO            (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_SIZE_1_HI              (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_SIZE_1_LO              (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_SIZE_2_HI              (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_SIZE_2_LO              (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_WORDS                  (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_GAS_MXP                (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_MTNTOP                 (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_SIZE_1_NONZERO_NO_MXPX (hub-into-mxp-trigger))
    (* hubshan.misc/MXP_SIZE_2_NONZERO_NO_MXPX (hub-into-mxp-trigger))
  ))

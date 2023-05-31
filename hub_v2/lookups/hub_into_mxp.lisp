(defun (hub-into-mxp-trigger)
  (and hub_v2.PEEK_AT_MISCELLANEOUS
       hub_v2.misc/MXP_FLAG))

(deflookup hub-into-mxp
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
           )
           ;; source columns
	   (
	     (* hub_v2.MXP_STAMP               (hub-into-mxp-trigger))
	     (* hub_v2.CONTEXT_NUMBER          (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_INST           (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_MXPX           (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_DEPLOYS        (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_OFFSET_1_HI    (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_OFFSET_1_LO    (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_OFFSET_2_HI    (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_OFFSET_2_LO    (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_SIZE_1_HI      (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_SIZE_1_LO      (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_SIZE_2_HI      (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_SIZE_2_LO      (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_WORDS          (hub-into-mxp-trigger))
	     (* hub_v2.misc/MXP_GAS_MXP        (hub-into-mxp-trigger))
           )
)
















(defun (hub-into-trm-trigger)
  (* hubshan.PEEK_AT_ACCOUNT
     hubshan.account/TRM_FLAG))

(deflookup hub-into-trm
           ;; target columns
           (
             trm.TRM_ADDRESS_HI
             trm.RAW_ADDRESS_HI
             trm.RAW_ADDRESS_LO
             trm.IS_PRECOMPILE
             )
           ;; source columns
           (
            (* hubshan.account/ADDRESS_HI                    (hub-into-trm-trigger))
            (* hubshan.account/TRM_RAW_ADDRESS_HI            (hub-into-trm-trigger))
            (* hubshan.account/ADDRESS_LO                    (hub-into-trm-trigger))
            (* hubshan.account/IS_PRECOMPILE                 (hub-into-trm-trigger))
            )
           )

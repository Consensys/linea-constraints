(defun    (hub-into-hub-source-selector-shan)    hubshan.scp_PEEK_AT_STORAGE)
(defun    (hub-into-hub-target-selector-shan)    hubshan.acp_PEEK_AT_ACCOUNT) ;; ""

(deflookup hub-into-hub---FIRST-FINAL-in-block-deployment-number-coherence
	   ;; target columns
	   (
	    (* hubshan.acp_ADDRESS_HI                                 (hub-into-hub-target-selector-shan))
	    (* hubshan.acp_ADDRESS_LO                                 (hub-into-hub-target-selector-shan))
	    (* hubshan.acp_REL_BLK_NUM                                (hub-into-hub-target-selector-shan))
	    (* hubshan.acp_DEPLOYMENT_NUMBER_FIRST_IN_BLOCK           (hub-into-hub-target-selector-shan))
	    (* hubshan.acp_DEPLOYMENT_NUMBER_FINAL_IN_BLOCK           (hub-into-hub-target-selector-shan))
	    (* hubshan.acp_EXISTS_FIRST_IN_BLOCK                      (hub-into-hub-target-selector-shan))
	    (* hubshan.acp_EXISTS_FINAL_IN_BLOCK                      (hub-into-hub-target-selector-shan))
	    )
	   ;; source columns
	   (
	    (* hubshan.scp_ADDRESS_HI                                 (hub-into-hub-source-selector-shan))
	    (* hubshan.scp_ADDRESS_LO                                 (hub-into-hub-source-selector-shan))
	    (* hubshan.scp_REL_BLK_NUM                                (hub-into-hub-source-selector-shan))
	    (* hubshan.scp_DEPLOYMENT_NUMBER_FIRST_IN_BLOCK           (hub-into-hub-source-selector-shan))
	    (* hubshan.scp_DEPLOYMENT_NUMBER_FINAL_IN_BLOCK           (hub-into-hub-source-selector-shan))
	    (* hubshan.scp_EXISTS_FIRST_IN_BLOCK                      (hub-into-hub-source-selector-shan))
	    (* hubshan.scp_EXISTS_FINAL_IN_BLOCK                      (hub-into-hub-source-selector-shan))
	    )
	   )


(defun (hub-into-rom-lex-trigger)
  (and hub.PEEK_AT_ACCOUNT
       hub.account/ROM_LEX_FLAG)) ;; TODO: the selector is different in the spec

(deflookup hub-into-rom-lex
           ;; target columns
	   ( 
	     romLex.CODE_FRAGMENT_INDEX
	     romLex.ADDRESS_HI
	     romLex.ADDRESS_LO       
	     romLex.DEPLOYMENT_NUMBER
	     romLex.DEPLOYMENT_STATUS
           )
           ;; source columns
	   (
	     (* hub.account/CODE_FRAGMENT_INDEX                (hub-into-rom-lex-trigger))
	     (* hub.account/ADDRESS_HI                         (hub-into-rom-lex-trigger))
	     (* hub.account/ADDRESS_LO                         (hub-into-rom-lex-trigger))
	     (* hub.account/DEPLOYMENT_NUMBER                  (hub-into-rom-lex-trigger))
	     (* hub.account/DEPLOYMENT_STATUS                  (hub-into-rom-lex-trigger))
           )
)

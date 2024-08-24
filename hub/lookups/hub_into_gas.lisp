(defun (hub-into-gas-trigger)
  (and hub.PEEK_AT_STACK
       hub.CMC))

(deflookup hub-into-gas
           ;; target columns
	   ( 
	     gas.GAS_ACTUAL
	     gas.GAS_COST
	     gas.XAHOY   ;; TODO @lorenzo: implement GAS module
	     gas.OOGX
           )
           ;; source columns
	   (
	     (* hub.GAS_ACTL      (hub-into-gas-trigger))
	     (* hub.GAS_COST      (hub-into-gas-trigger))
	     (* hub.XAHOY         (hub-into-gas-trigger))
	     (* hub.stack/OOGX    (hub-into-gas-trigger))
           )
)

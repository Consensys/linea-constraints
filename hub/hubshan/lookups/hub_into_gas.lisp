(defun (hub-into-gas-trigger-shan) (* hubshan.PEEK_AT_STACK hubshan.CMC))

(deflookup hub-into-gas
           ;; target columns
	   (
	     gas.IOMF
	     gas.GAS_ACTUAL
	     gas.GAS_COST
	     gas.EXCEPTIONS_AHOY
	     gas.OUT_OF_GAS_EXCEPTION
           )
           ;; source columns
	   (
	                          (hub-into-gas-trigger-shan)
	     (* hubshan.GAS_ACTUAL    (hub-into-gas-trigger-shan))
	     (* hubshan.GAS_COST      (hub-into-gas-trigger-shan))
	     (* hubshan.XAHOY         (hub-into-gas-trigger-shan))
	     (* hubshan.stack/OOGX    (hub-into-gas-trigger-shan))
           )
)

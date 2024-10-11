(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                         ;;
;;    X.Y.5 Specifics for RETURNDATACOPY   ;;
;;                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint copy-instruction---RETURNDATACOPY---setting-the-gas-cost       (:guard (copy-instruction---standard-RETURNDATACOPY))
               (begin
                 (if-not-zero   stack/RDCX   (vanishes!   GAS_COST))
                 (if-not-zero   stack/MXPX   (vanishes!   GAS_COST))
                 (if-not-zero   stack/OOGX   (eq!         GAS_COST    (+ stack/STATIC_GAS (copy-instruction---MXP-memory-expansion-gas))))
                 (if-zero       XAHOY        (eq!         GAS_COST    (+ stack/STATIC_GAS (copy-instruction---MXP-memory-expansion-gas))))))

(defconstraint copy-instruction---RETURNDATACOPY---setting-the-context-rows   (:guard (copy-instruction---standard-RETURNDATACOPY))
               (begin
                 (read-context-data                                             ROW_OFFSET_RETURNDATACOPY_CURRENT_CONTEXT_ROW     CONTEXT_NUMBER)
                 (if-not-zero   XAHOY   (execution-provides-empty-return-data   ROW_OFFSET_RETURNDATACOPY_CALLER_CONTEXT_ROW  ))))

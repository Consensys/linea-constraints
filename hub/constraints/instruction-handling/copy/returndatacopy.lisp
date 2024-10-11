(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                         ;;
;;    X.Y.5 Specifics for RETURNDATACOPY   ;;
;;                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint copy-setting-the-gas-cost-for-RETURNDATACOPY (:guard (copy-instruction---standard-RETURNDATACOPY))
               (begin
                 (if-not-zero   stack/RDCX   (vanishes!   GAS_COST))
                 (if-not-zero   stack/MXPX   (vanishes!   GAS_COST))
                 (if-not-zero   stack/OOGX   (eq!         GAS_COST    (+ stack/STATIC_GAS (copy-instruction---MXP-memory-expansion-gas))))
                 (if-zero       XAHOY        (eq!         GAS_COST    (+ stack/STATIC_GAS (copy-instruction---MXP-memory-expansion-gas))))))

(defconstraint copy-setting-the-context-row-for-RETURNDATACOPY (:guard (copy-instruction---standard-RETURNDATACOPY))
               (begin
                 (if-not-zero   stack/RDCX   (begin (read-context-data                      ROW_OFFSET_RETURNDATACOPY_CURRENT_CONTEXT_ROW    CONTEXT_NUMBER)
                                                    (execution-provides-empty-return-data   ROW_OFFSET_RETURNDATACOPY_CALLER_CONTEXT_ROW_RDCX)))
                 (if-not-zero   stack/MXPX   (execution-provides-empty-return-data          ROW_OFFSET_RETURNDATACOPY_CALLER_CONTEXT_ROW))
                 (if-not-zero   stack/OOGX   (execution-provides-empty-return-data          ROW_OFFSET_RETURNDATACOPY_CALLER_CONTEXT_ROW))
                 (if-zero       XAHOY        (read-context-data                             ROW_OFFSET_RETURNDATACOPY_CURRENT_CONTEXT_ROW    CONTEXT_NUMBER))))


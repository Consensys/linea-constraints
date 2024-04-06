(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                                  ;;;;
;;;;    X.Y COPY instruction family   ;;;;
;;;;                                  ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ;;
;;    X.Y.1 Introduction     ;;
;;    X.Y.2 Shorthands       ;;
;;                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconst
  ROW_OFFSET_COPY_INST_MISCELLANEOUS_ROW                     1
  ;;
  ROW_OFFSET_CALLDATACOPY_CONTEXT_ROW                        2
  ;;
  ROW_OFFSET_RETURNDATACOPY_CONTEXT_ROW                      2
  ROW_OFFSET_RETURNDATACOPY_NO_RDCX_ACCOUNT_ROW              3
  ;;
  ROW_OFFSET_CODECOPY_XAHOY_CONTEXT_ROW                      2
  ROW_OFFSET_CODECOPY_NO_XAHOY_CONTEXT_ROW                   2
  ROW_OFFSET_CODECOPY_NO_XAHOY_ACCOUNT_ROW                   3
  ;;
  ROW_OFFSET_EXTCODECOPY_MXPX_CONTEXT_ROW                    2
  ROW_OFFSET_EXTCODECOPY_OOGX_CONTEXT_ROW                    2
  ROW_OFFSET_EXTCODECOPY_OOGX_ACCOUNT_ROW                    3
  ROW_OFFSET_EXTCODECOPY_NO_XAHOY_REVERT_ACCOUNT_DOING_ROW   2
  ROW_OFFSET_EXTCODECOPY_NO_XAHOY_REVERT_ACCOUNT_UNDOING_ROW 3
  ROW_OFFSET_EXTCODECOPY_NO_XAHOY_NO_REVERT_ACCOUNT_ROW      2
  )

;; (defun (copy-inst-instruction)                                  stack/INSTRUCTION    )
;; ;;
;; (defun (copy-inst-is-CALLDATACOPY)                              [ stack/DEC_FLAG 1 ] )
;; (defun (copy-inst-is-RETURNDATACOPY)                            [ stack/DEC_FLAG 2 ] )
;; (defun (copy-inst-is-CODECOPY)                                  [ stack/DEC_FLAG 3 ] )
;; (defun (copy-inst-is-EXTCODECOPY)                               [ stack/DEC_FLAG 4 ] )
;; ;;
;; (defun (copy-inst-target-offset-hi)                             [ stack/STACK_ITEM_VALUE_HI 1 ] )
;; (defun (copy-inst-target-offset-lo)                             [ stack/STACK_ITEM_VALUE_LO 1 ] )
;; (defun (copy-inst-source-offset-hi)                             [ stack/STACK_ITEM_VALUE_HI 2 ] )
;; (defun (copy-inst-source-offset-lo)                             [ stack/STACK_ITEM_VALUE_LO 2 ] )
;; (defun (copy-inst-size-hi)                                      [ stack/STACK_ITEM_VALUE_HI 3 ] )
;; (defun (copy-inst-size-lo)                                      [ stack/STACK_ITEM_VALUE_LO 3 ] )
;; (defun (copy-inst-raw-address-hi)                               [ stack/STACK_ITEM_VALUE_HI 4 ] )
;; (defun (copy-inst-raw-address-lo)                               [ stack/STACK_ITEM_VALUE_LO 4 ] )
;; ;;
;; (defun (copy-inst-OOB-raises-return-data-exception)             ( shift    [ misc/OOB_DATA 7 ]    ROW_OFFSET_COPY_INST_MISCELLANEOUS_ROW )
;; (defun (copy-inst-MXP-raises-memory-expansion-exception)        ( shift    misc/MXP_MXPX          ROW_OFFSET_COPY_INST_MISCELLANEOUS_ROW )
;; (defun (copy-inst-MXP-memory-expansion-gas)                     ( shift    misc/MXP_GAS_MXP       ROW_OFFSET_COPY_INST_MISCELLANEOUS_ROW )
;; ;;
;; (defun (copy-inst-call-data-context)                            ( shift    context/CALL_DATA_CONTEXT_NUMBER    ROW_OFFSET_CALLDATACOPY_CONTEXT_ROW )
;; (defun (copy-inst-call-data-offset)                             ( shift    context/CALL_DATA_OFFSET            ROW_OFFSET_CALLDATACOPY_CONTEXT_ROW )
;; (defun (copy-inst-call-data-size)                               ( shift    context/CALL_DATA_SIZE              ROW_OFFSET_CALLDATACOPY_CONTEXT_ROW )
;; (defun (copy-inst-return-data-context)                          ( shift    context/RETURN_DATA_CONTEXT_NUMBER    ROW_OFFSET_RETURNDATACOPY_CONTEXT_ROW )
;; (defun (copy-inst-return-data-offset)                           ( shift    context/RETURN_DATA_OFFSET            ROW_OFFSET_RETURNDATACOPY_CONTEXT_ROW )
;; (defun (copy-inst-return-data-size)                             ( shift    context/RETURN_DATA_SIZE              ROW_OFFSET_RETURNDATACOPY_CONTEXT_ROW )
;; ;;
;; (defun (copy-inst-address-warmth)                               ( shift    account/WARMTH                 ROW_OFFSET_EXTCODECOPY_ACCOUNT_ROW )
;; (defun (copy-inst-address-has-code)                             ( shift    account/HAS_CODE               ROW_OFFSET_EXTCODECOPY_ACCOUNT_ROW )
;; (defun (copy-inst-address-code-size)                            ( shift    account/CODE_SIZE              ROW_OFFSET_EXTCODECOPY_ACCOUNT_ROW )
;; (defun (copy-inst-address-code-fragment-index)                  ( shift    account/CODE_FRAGMENT_INDEX    ROW_OFFSET_EXTCODECOPY_ACCOUNT_ROW )


(defun (copy-inst-standard-precondition)  (*  PEEK_AT_STACK
                                         stack/COPY_FLAG
                                         (- 1   stack/SUX   stack/SOX)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                ;;
;;    X.Y.3 General constraints   ;;
;;                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint    copy-setting-the-stack-pattern                                             (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-allowable-exceptions                                                  (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-setting-NSR-and-peeking-flags-CALLDATACOPY-case                       (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-setting-NSR-and-peeking-flags-RETURNDATACOPY-case                     (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-setting-NSR-and-peeking-flags-CODECOPY-case                           (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-setting-NSR-and-peeking-flags-EXTCODECOPY-case                        (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-setting-misc-row-module-flags                                         (:guard    (copy-inst-standard-precondition))
(defun            (copy-inst-trigger-OOB)
(defun            (copy-inst-trigger-MXP)
(defun            (copy-inst-trigger-MMU)
(defconstraint    copy-misc-row-setting-OOB-instruction                                      (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-misc-row-setting-RDCX                                                 (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-misc-row-setting-MXP-instruction                                      (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-misc-row-setting-MXPX                                                 (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-misc-row-partially-setting-the-MMU-instruction                        (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-misc-row-finishing-setting-the-MMU-instruction-CALLDATACOPY-case      (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-misc-row-finishing-setting-the-MMU-instruction-RETURNDATACOPY-case    (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-misc-row-finishing-setting-the-MMU-instruction-CODECOPY-case          (:guard    (copy-inst-standard-precondition))
(defconstraint    copy-misc-row-finishing-setting-the-MMU-instruction-EXTCODECOPY-case       (:guard    (copy-inst-standard-precondition))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                       ;;
;;    X.Y.4 Specifics for CALLDATACOPY   ;;
;;                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint   copy-setting-the-gas-cost-for-CALLDATACOPY                      (:guard   (*   (copy-inst-standard-precondition)   (copy-inst-is-CALLDATACOPY)))
(defconstraint   copy-setting-the-context-row-for-CALLDATACOPY                   (:guard   (*   (copy-inst-standard-precondition)   (copy-inst-is-CALLDATACOPY)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                         ;;
;;    X.Y.5 Specifics for RETURNDATACOPY   ;;
;;                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint   copy-setting-the-gas-cost-for-RETURNDATACOPY                   (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-RETURNDATACOPY)))
(defconstraint   copy-setting-the-context-row-for-RETURNDATACOPY                (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-RETURNDATACOPY)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                   ;;
;;    X.Y.6 Specifics for CODECOPY   ;;
;;                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint   copy-setting-the-gas-cost-for-CODECOPY                         (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-CODECOPY)))
(defconstraint   copy-setting-the-context-row-for-exceptional-CODECOPY          (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-CODECOPY)))
(defconstraint   copy-setting-the-context-row-for-unexceptional-CODECOPY        (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-CODECOPY)))
(defconstraint   copy-setting-the-account-row-for-unexceptional-CODECOPY        (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-CODECOPY)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                      ;;
;;    X.Y.7 Specifics for EXTCODECOPY   ;;
;;                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun           (copy-inst-trigger-CFI)

(defconstraint   copy-setting-the-gas-cost-for-EXTCODECOPY                                        (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-EXTCODECOPY)))
(defconstraint   copy-the-MXPX-case-for-EXTCODECOPY                                               (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-EXTCODECOPY)))
(defconstraint   copy-the-OOGX-case-for-EXTCODECOPY                                               (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-EXTCODECOPY)))
(defconstraint   copy-inst-unexceptional-reverted-EXTCODECOPY-doing-account-row                   (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-EXTCODECOPY)))
(defconstraint   copy-inst-unexceptional-reverted-EXTCODECOPY-undoing-account-row                 (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-EXTCODECOPY)))
(defconstraint   copy-inst-unexceptional-unreverted-EXTCODECOPY-account-row                       (:guard   (*   (copy-inst-standard-precondition)    (copy-inst-is-EXTCODECOPY)))

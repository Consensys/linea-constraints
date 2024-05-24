(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                ;;;;
;;;;    X.Y CALL    ;;;;
;;;;                ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    X.Y.6 Shorthands   ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun    (call-instruction---is-CALL)                           (shift    [stack/DEC_FLAG  1]                 CALL_1st_stack_row___row_offset))
(defun    (call-instruction---is-CALLCODE)                       (shift    [stack/DEC_FLAG  2]                 CALL_1st_stack_row___row_offset))
(defun    (call-instruction---is-DELEGATECALL)                   (shift    [stack/DEC_FLAG  3]                 CALL_1st_stack_row___row_offset))
(defun    (call-instruction---is-STATICCALL)                     (shift    [stack/DEC_FLAG  4]                 CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-staticx)                     (shift    stack/STATICX                       CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-mxpx)                        (shift    stack/MXPX                          CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-oogx)                        (shift    stack/OOGX                          CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-instruction)                 (shift    stack/INSTRUCTION                   CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-cdo-hi)                      (shift    [stack/STACK_ITEM_VALUE_HI  1]      CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-cdo-lo)                      (shift    [stack/STACK_ITEM_VALUE_LO  1]      CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-cds-hi)                      (shift    [stack/STACK_ITEM_VALUE_HI  2]      CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-cds-lo)                      (shift    [stack/STACK_ITEM_VALUE_LO  2]      CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-r@o-hi)                      (shift    [stack/STACK_ITEM_VALUE_HI  3]      CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-r@o-lo)                      (shift    [stack/STACK_ITEM_VALUE_LO  3]      CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-r@c-hi)                      (shift    [stack/STACK_ITEM_VALUE_HI  4]      CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-r@c-lo)                      (shift    [stack/STACK_ITEM_VALUE_LO  4]      CALL_1st_stack_row___row_offset))
(defun    (call-instruction---STACK-gas-hi)                      (shift    [stack/STACK_ITEM_VALUE_HI  1]      CALL_2nd_stack_row___row_offset))
(defun    (call-instruction---STACK-gas-lo)                      (shift    [stack/STACK_ITEM_VALUE_LO  1]      CALL_2nd_stack_row___row_offset))
(defun    (call-instruction---STACK-raw-callee-address-hi)       (shift    [stack/STACK_ITEM_VALUE_HI  2]      CALL_2nd_stack_row___row_offset))
(defun    (call-instruction---STACK-raw-callee-address-lo)       (shift    [stack/STACK_ITEM_VALUE_LO  2]      CALL_2nd_stack_row___row_offset))
(defun    (call-instruction---STACK-value-hi)                    (shift    [stack/STACK_ITEM_VALUE_HI  3]      CALL_2nd_stack_row___row_offset))
(defun    (call-instruction---STACK-value-lo)                    (shift    [stack/STACK_ITEM_VALUE_LO  3]      CALL_2nd_stack_row___row_offset))
(defun    (call-instruction---STACK-success-bit-hi)              (shift    [stack/STACK_ITEM_VALUE_HI  4]      CALL_2nd_stack_row___row_offset))
(defun    (call-instruction---STACK-success-bit-lo)              (shift    [stack/STACK_ITEM_VALUE_LO  4]      CALL_2nd_stack_row___row_offset))
(defun    (call-instruction---gas-actual)                        (shift    GAS_ACTUAL                          CALL_2nd_stack_row___row_offset  ))
(defun    (call-instruction---current-address-hi)                (shift    context/ACCOUNT_ADDRESS_HI          CALL_1st_context_row___row_offset))
(defun    (call-instruction---current-address-lo)                (shift    context/ACCOUNT_ADDRESS_LO          CALL_1st_context_row___row_offset))
(defun    (call-instruction---current-context-is-static)         (shift    context/IS_STATIC                   CALL_1st_context_row___row_offset))
(defun    (call-instruction---current-caller-address-hi)         (shift    context/CALLER_ADDRESS_HI           CALL_1st_context_row___row_offset))
(defun    (call-instruction---current-caller-address-lo)         (shift    context/CALLER_ADDRESS_LO           CALL_1st_context_row___row_offset))
(defun    (call-instruction---current-call-value)                (shift    context/CALL_VALUE                  CALL_1st_context_row___row_offset))
(defun    (call-instruction---current-call-stack-depth)          (shift    context/CALL_STACK_DEPTH            CALL_1st_context_row___row_offset))
(defun    (call-instruction---MXP-memory-expansion-exception)    (shift    misc/MXP_MXPX                       CALL_misc_row___row_offset))
(defun    (call-instruction---MXP-memory-expansion-gas)          (shift    misc/MXP_GAS_MXP                    CALL_misc_row___row_offset))
(defun    (call-instruction---STP-gas-upfront)                   (shift    misc/STP_GAS_UPFRONT_GAS_COST       CALL_misc_row___row_offset))
(defun    (call-instruction---STP-gas-paid-out-of-pocket)        (shift    misc/STP_GAS_PAID_OUT_OF_POCKET     CALL_misc_row___row_offset))
(defun    (call-instruction---STP-call-stipend)                  (shift    misc/STP_GAS_STIPEND                CALL_misc_row___row_offset))
(defun    (call-instruction---STP-out-of-gas-exception)          (shift    misc/STP_OOGX                       CALL_misc_row___row_offset))
(defun    (call-instruction---OOB-nonzero-value)                 (shift    [misc/OOB_DATA  7]                  CALL_misc_row___row_offset))
(defun    (call-instruction---OOB-aborting-condition)            (shift    [misc/OOB_DATA  8]                  CALL_misc_row___row_offset))
(defun    (call-instruction---caller-balance)                    (shift    account/BALANCE                     CALL_1st_caller_account_row___row_offset))
(defun    (call-instruction---callee-address-hi)                 (shift    account/ADDRESS_HI                  CALL_1st_callee_account_row___row_offset))
(defun    (call-instruction---callee-address-lo)                 (shift    account/ADDRESS_LO                  CALL_1st_callee_account_row___row_offset))
(defun    (call-instruction---callee-code-fragment-index)        (shift    account/CODE_FRAGMENT_INDEX         CALL_1st_callee_account_row___row_offset))
(defun    (call-instruction---callee-has-code)                   (shift    account/HAS_CODE                    CALL_1st_callee_account_row___row_offset))
(defun    (call-instruction---callee-warmth)                     (shift    account/WARMTH                      CALL_1st_callee_account_row___row_offset))
(defun    (call-instruction---callee-exists)                     (shift    account/EXISTS                      CALL_1st_callee_account_row___row_offset))
(defun    (call-instruction---callee-is-precompile)              (shift    account/IS_PRECOMPILE               CALL_1st_callee_account_row___row_offset))

;; revert data shorthands
(defun    (call-instruction---caller-will-revert)     (shift    CONTEXT_WILL_REVERT     CALL_1st_stack_row___row_offset))
(defun    (call-instruction---caller-revert-stamp)    (shift    CONTEXT_REVERT_STAMP    CALL_1st_stack_row___row_offset))
(defun    (call-instruction---callee-self-reverts)    (shift    misc/CCSR_FLAG          CALL_misc_row___row_offset))
(defun    (call-instruction---callee-revert-stamp)    (shift    misc/CCRS_STAMP         CALL_misc_row___row_offset))

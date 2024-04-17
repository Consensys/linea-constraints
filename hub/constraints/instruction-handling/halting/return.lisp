(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                 ;;;;
;;;;    X.Y RETURN   ;;;;
;;;;                 ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                ;;
;;    X.Y.1 Introduction          ;;
;;    X.Y.2 Scenario row seting   ;;
;;                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun  (return-inst-standard-stack-hypothesis)  (*  PEEK_AT_STACK
                                                stack/HALT_FLAG
                                                [ stack/DEC_FLAG 1 ]
                                                (-  1  stack/SUX )))

(defun  (return-inst-standard-scenario-row)  (* PEEK_AT_SCENARIO
                                                (scen-RETURN-shorthand-sum)))

(defconstraint   return-inst-imposing-some-RETURN-scenario  (:guard  (return-inst-standard-stack-hypothesis))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (begin  (eq!  (next  PEEK_AT_SCENARIO)             1)
                         (eq!  (next  (scen-RETURN-shorthand-sum))  1)))


;; Note: we could pack into a single constraint the last 3 constraints.
(defconstraint   return-inst-imposing-the-converse  (:guard  (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (begin  (eq!        (prev  PEEK_AT_STACK)         1)
                         (eq!        (prev  stack/HALT_FLAG)       1)
                         (eq!        (prev  [ stack/DEC_FLAG 1 ])  1)
                         (vanishes!  (prev  (+ stack/SUX stack/SOX)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    X.Y.3 Shorthands   ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;




(defconst
  RETURN_INST_STACK_ROW_OFFSET                                          -1
  RETURN_INST_SCENARIO_ROW_OFFSET                                        0
  RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET                                 1
  RETURN_INST_FIRST_MISC_ROW_OFFSET                                      2
  RETURN_INST_SECOND_MISC_ROW_OFFSET_DEPLOY_AND_HASH                     3
  RETURN_INST_EMPTY_DEPLOYMENT_FIRST_ACCOUNT_ROW_OFFSET                  3
  RETURN_INST_EMPTY_DEPLOYMENT_SECOND_ACCOUNT_ROW_OFFSET                 4
  RETURN_INST_NONEMPTY_DEPLOYMENT_FIRST_ACCOUNT_ROW_OFFSET               4
  RETURN_INST_NONEMPTY_DEPLOYMENT_SECOND_ACCOUNT_ROW_OFFSET              5
  RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_EXCEPTION                        3
  RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_MESSAGE_CALL                     3
  RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_EMPTY_DEPLOYMENT_WILL_REVERT     5
  RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_EMPTY_DEPLOYMENT_WONT_REVERT     4
  RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_NONEMPTY_DEPLOYMENT_WILL_REVERT  6
  RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_NONEMPTY_DEPLOYMENT_WONT_REVERT  5
  )



(defun (return-inst-instruction)                                (shift   stack/INSTRUCTION                                  RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-exception-flag-MXPX)                        (shift   stack/MXPX                                         RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-exception-flag-OOGX)                        (shift   stack/OOGX                                         RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-exception-flag-MAXCSX)                      (shift   stack/MAXCSX                                       RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-exception-flag-ICPX)                        (shift   stack/ICPX                                         RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-offset-hi)                                  (shift   [ stack/STACK_ITEM_VALUE_HI 1]                     RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-offset-lo)                                  (shift   [ stack/STACK_ITEM_VALUE_LO 1]                     RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-size-hi)                                    (shift   [ stack/STACK_ITEM_VALUE_HI 2]                     RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-size-lo)                                    (shift   [ stack/STACK_ITEM_VALUE_LO 2]                     RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-code-hash-hi)                               (shift   HASH_INFO_KECCAK_HI                                RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-code-hash-lo)                               (shift   HASH_INFO_KECCAK_LO                                RETURN_INST_STACK_ROW_OFFSET))
(defun (return-inst-is-root)                                    (shift   context/IS_ROOT                                    RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET))
(defun (return-inst-deployment-address-hi)                      (shift   context/BYTE_CODE_ADDRESS_HI                       RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET))
(defun (return-inst-deployment-address-lo)                      (shift   context/BYTE_CODE_ADDRESS_LO                       RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET))
(defun (return-inst-is-deployment)                              (shift   context/BYTE_CODE_DEPLOYMENT_STATUS                RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET))
(defun (return-inst-return-at-offset)                           (shift   context/RETURN_AT_OFFSET                           RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET))
(defun (return-inst-return-at-capacity)                         (shift   context/RETURN_AT_CAPACITY                         RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET))
(defun (return-inst-MXP-may-trigger-non-trivial-operation)      (shift   misc/MXP_MTNTOP                                    RETURN_INST_FIRST_MISC_ROW_OFFSET))
(defun (return-inst-MXP-memory-expansion-gas)                   (shift   misc/MXP_GAS_MXP                                   RETURN_INST_FIRST_MISC_ROW_OFFSET))
(defun (return-inst-MXP-memory-expansion-exception)             (shift   misc/MXP_MXPX                                      RETURN_INST_FIRST_MISC_ROW_OFFSET))
(defun (return-inst-MMU-success-bit)                            (shift   misc/MMU_SUCCESS_BIT                               RETURN_INST_FIRST_MISC_ROW_OFFSET))
(defun (return-inst-OOB-max-code-size-exception)                (shift   [ misc/OOB_DATA 7 ]                                RETURN_INST_FIRST_MISC_ROW_OFFSET))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;    X.Y.4 Generalities   ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint return-inst-acceptable-exceptions  (:guard  PEEK_AT_SCENARIO)
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (begin
                 (if-not-zero  (scen-RETURN-shorthand-message-call)
                               (eq!  XAHOY
                                     (+  (return-inst-exception-flag-MXPX)
                                         (return-inst-exception-flag-OOGX))))
                 (if-not-zero  (scen-RETURN-shorthand-deployment)
                               (eq!  XAHOY
                                     (+  (return-inst-exception-flag-MXPX)
                                         (return-inst-exception-flag-OOGX)
                                         (return-inst-exception-flag-MAXCSX)
                                         (return-inst-exception-flag-ICPX))))))

(defconstraint   return-inst-setting-stack-pattern               (:guard  (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (prev (stack-pattern-2-0)))

(defconstraint   return-inst-setting-NSR               (:guard  (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;
                 (eq!  NSR
                       (+  (* 4 scenario/RETURN_EXCEPTION                                 )
                           (* 4 scenario/RETURN_FROM_MESSAGE_CALL_WILL_TOUCH_RAM          )
                           (* 4 scenario/RETURN_FROM_MESSAGE_CALL_WONT_TOUCH_RAM          )
                           (* 6 scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WILL_REVERT    )
                           (* 5 scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WONT_REVERT    )
                           (* 7 scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WILL_REVERT )
                           (* 6 scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WONT_REVERT ))))
                 
(defconstraint   return-inst-setting-peeking-flags                   (:guard  (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (begin
                   (if-not-zero   scenario/RETURN_EXCEPTION
                                  (eq!  NSR
                                        (+  (shift  PEEK_AT_SCENARIO        RETURN_INST_SCENARIO_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET)
                                            (shift  PEEK_AT_MISCELLANEOUS   RETURN_INST_FIRST_MISC_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_EXCEPTION))))
                   (if-not-zero   scenario/RETURN_FROM_MESSAGE_CALL_WILL_TOUCH_RAM
                                  (eq!  NSR
                                        (+  (shift  PEEK_AT_SCENARIO        RETURN_INST_SCENARIO_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET)
                                            (shift  PEEK_AT_MISCELLANEOUS   RETURN_INST_FIRST_MISC_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_MESSAGE_CALL))))
                   (if-not-zero   scenario/RETURN_FROM_MESSAGE_CALL_WONT_TOUCH_RAM
                                  (eq!  NSR
                                        (+  (shift  PEEK_AT_SCENARIO        RETURN_INST_SCENARIO_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET)
                                            (shift  PEEK_AT_MISCELLANEOUS   RETURN_INST_FIRST_MISC_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_MESSAGE_CALL))))
                   (if-not-zero   scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WILL_REVERT
                                  (eq!  NSR
                                        (+  (shift  PEEK_AT_SCENARIO        RETURN_INST_SCENARIO_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET)
                                            (shift  PEEK_AT_MISCELLANEOUS   RETURN_INST_FIRST_MISC_ROW_OFFSET)
                                            (shift  PEEK_AT_ACCOUNT         RETURN_INST_EMPTY_DEPLOYMENT_FIRST_ACCOUNT_ROW_OFFSET )
                                            (shift  PEEK_AT_ACCOUNT         RETURN_INST_EMPTY_DEPLOYMENT_SECOND_ACCOUNT_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_EMPTY_DEPLOYMENT_WILL_REVERT))))
                   (if-not-zero   scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WONT_REVERT
                                  (eq!  NSR
                                        (+  (shift  PEEK_AT_SCENARIO        RETURN_INST_SCENARIO_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET)
                                            (shift  PEEK_AT_MISCELLANEOUS   RETURN_INST_FIRST_MISC_ROW_OFFSET)
                                            (shift  PEEK_AT_ACCOUNT         RETURN_INST_EMPTY_DEPLOYMENT_FIRST_ACCOUNT_ROW_OFFSET )
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_EMPTY_DEPLOYMENT_WONT_REVERT))))
                   (if-not-zero   scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WILL_REVERT
                                  (eq!  NSR
                                        (+  (shift  PEEK_AT_SCENARIO        RETURN_INST_SCENARIO_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET)
                                            (shift  PEEK_AT_MISCELLANEOUS   RETURN_INST_FIRST_MISC_ROW_OFFSET)
                                            (shift  PEEK_AT_MISCELLANEOUS   RETURN_INST_SECOND_MISC_ROW_OFFSET_DEPLOY_AND_HASH)
                                            (shift  PEEK_AT_ACCOUNT         RETURN_INST_NONEMPTY_DEPLOYMENT_FIRST_ACCOUNT_ROW_OFFSET )
                                            (shift  PEEK_AT_ACCOUNT         RETURN_INST_NONEMPTY_DEPLOYMENT_SECOND_ACCOUNT_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_NONEMPTY_DEPLOYMENT_WILL_REVERT))))
                   (if-not-zero   scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WONT_REVERT
                                  (eq!  NSR
                                        (+  (shift  PEEK_AT_SCENARIO        RETURN_INST_SCENARIO_ROW_OFFSET)
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET)
                                            (shift  PEEK_AT_MISCELLANEOUS   RETURN_INST_FIRST_MISC_ROW_OFFSET)
                                            (shift  PEEK_AT_MISCELLANEOUS   RETURN_INST_SECOND_MISC_ROW_OFFSET_DEPLOY_AND_HASH)
                                            (shift  PEEK_AT_ACCOUNT         RETURN_INST_NONEMPTY_DEPLOYMENT_FIRST_ACCOUNT_ROW_OFFSET )
                                            (shift  PEEK_AT_CONTEXT         RETURN_INST_CALLER_CONTEXT_ROW_OFFSET_NONEMPTY_DEPLOYMENT_WONT_REVERT))))))

(defconstraint   return-inst-first-context-row                   (:guard  (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (read-context-data   RETURN_INST_CURRENT_CONTEXT_ROW_OFFSET
                                      CONTEXT_NUMBER))
                 
(defconstraint   return-inst-refining-the-return-scenario        (:guard  (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (begin
                   (eq!  scenario/RETURN_EXCEPTION  XAHOY)
                   (if-not-zero  (scen-RETURN-shorthand-unexceptional)
                                 (eq!  (scen-RETURN-shorthand-deployment)  (return-inst-is-deployment)))
                   (if-not-zero  (scen-RETURN-shorthand-deployment)
                                 (begin
                                    (eq!  (scen-RETURN-shorthand-deployment-will-revert)  CONTEXT_WILL_REVERT)
                                    (eq!  (scen-RETURN-shorthand-nonempty-deployment)     (return-inst-MXP-may-trigger-non-trivial-operation))))
                   (if-not-zero  (scen-RETURN-shorthand-message-call)
                                 (if-zero  (return-touch-ram-expression)
                                           ;; touch_ram_expression = 0
                                           (eq!  scenario/RETURN_FROM_MESSAGE_CALL_WONT_TOUCH_RAM  1)
                                           ;; touch_ram_expression ≠ 0
                                           (eq!  scenario/RETURN_FROM_MESSAGE_CALL_WILL_TOUCH_RAM  1)))))

(defun  (return-touch-ram-expression)  (*  (-  1  (return-inst-is-root))
                                           (return-inst-MXP-may-trigger-non-trivial-operation)
                                           (return-inst-return-at-capacity)))

(defconstraint return-inst-setting-the-first-misc-row  (:guard  (return-inst-standard-scenario-row))
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               (eq!   (weighted-MISC-flag-sum   RETURN_INST_FIRST_MISC_ROW_OFFSET)
                      (+   (*   MISC_WEIGHT_MMU   (return-inst-trigger_MMU))
                           (*   MISC_WEIGHT_MXP   (return-inst-trigger_MXP))
                           (*   MISC_WEIGHT_OOB   (return-inst-trigger_OOB)))))

(defun  (return-inst-trigger_MXP)                     1)   ;;                             does this syntax make sense ?
(defun  (return-inst-trigger_OOB)                     (+  (return-inst-exception-flag-MAXCSX)
                                                          (scen-RETURN-shorthand-nonempty-deployment)))
(defun  (return-inst-trigger_MMU)                     (+  (return-inst-check-first-byte)
                                                          (return-inst-write-return-data-to-caller-ram)))
(defun  (return-inst-check-first-byte)                (+  (return-inst-exception-flag-ICPX)
                                                          (scen-RETURN-shorthand-nonempty-deployment)))
(defun  (return-inst-write-return-data-to-caller-ram) scenario/RETURN_FROM_MESSAGE_CALL_WILL_TOUCH_RAM)
(defun  (return-inst-trigger_HASHINFO)                (scen-RETURN-shorthand-nonempty-deployment))

(defconstraint   return-inst-triggering-HASHINFO           (:guard   (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (eq!   (shift   stack/HASH_INFO_FLAG   RETURN_INST_STACK_ROW_OFFSET)
                        (return-inst-trigger_HASHINFO)))

(defconstraint   return-inst-setting-MXP-data              (:guard   (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (set-MXP-instruction-type-4   RETURN_INST_FIRST_MISC_ROW_OFFSET   ;; row offset kappa
                                               (return-inst-instruction)           ;; instruction
                                               (return-inst-is-deployment)         ;; bit modifying the behaviour of RETURN pricing
                                               (return-inst-offset-hi)             ;; offset high
                                               (return-inst-offset-lo)             ;; offset low
                                               (return-inst-size-hi)               ;; size high
                                               (return-inst-size-lo)))             ;; size low

(defconstraint   return-inst-setting-OOB-data              (:guard   (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (if-not-zero   (shift   misc/OOB_FLAG     RETURN_INST_FIRST_MISC_ROW_OFFSET)
                                (set-OOB-inst-deployment   RETURN_INST_FIRST_MISC_ROW_OFFSET   ;; offset
                                                           (return-inst-size-hi)                        ;; code size hi
                                                           (return-inst-size-lo) )))                    ;; code size lo
                                                         
                                
(defconstraint   return-inst-setting-MMU-data-first-call   (:guard   (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (begin
                   (if-not-zero   (return-inst-check-first-byte)
                                  (set-MMU-inst-invalid-code-prefix    RETURN_INST_FIRST_MISC_ROW_OFFSET       ;; offset
                                                                       CONTEXT_NUMBER                         ;; source ID
                                                                       ;; tgt_id                              ;; target ID
                                                                       ;; aux_id                              ;; auxiliary ID
                                                                       ;; src_offset_hi                       ;; source offset high
                                                                       (return-inst-offset-lo)             ;; source offset low
                                                                       ;; tgt_offset_lo                       ;; target offset low
                                                                       ;; size                                ;; size
                                                                       ;; ref_offset                          ;; reference offset
                                                                       ;; ref_size                            ;; reference size
                                                                       (return-inst-exception-flag-ICPX)   ;; success bit
                                                                       ;; limb_1                              ;; limb 1
                                                                       ;; limb_2                              ;; limb 2
                                                                       ;; exo_sum                             ;; weighted exogenous module flag sum
                                                                       ;; phase                               ;; phase
                                                                       ))
                   (if-not-zero   (return-inst-write-return-data-to-caller-ram)
                                  (set-MMU-inst-ram-to-ram-sans-padding   RETURN_INST_FIRST_MISC_ROW_OFFSET   ;; offset
                                                                          CONTEXT_NUMBER                      ;; source ID
                                                                          CALLER_CONTEXT_NUMBER               ;; target ID
                                                                          ;; aux_id                              ;; auxiliary ID
                                                                          ;; src_offset_hi                       ;; source offset high
                                                                          (return-inst-offset-lo)             ;; source offset low
                                                                          ;; tgt_offset_lo                       ;; target offset low
                                                                          (return-inst-size-lo)               ;; size
                                                                          (return-inst-return-at-offset)      ;; reference offset
                                                                          (return-inst-return-at-capacity)    ;; reference size
                                                                          ;; success_bit                         ;; success bit
                                                                          ;; limb_1                              ;; limb 1
                                                                          ;; limb_2                              ;; limb 2
                                                                          ;; exo_sum                             ;; weighted exogenous module flag sum
                                                                          ;; phase                               ;; phase
                                                                          ))))

(defconstraint   return-inst-justifying-the-MXPX           (:guard   (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (eq!   (return-inst-exception-flag-MXPX)
                        (return-inst-MXP-memory-expansion-exception)))

(defconstraint   return-inst-justifying-the-ICPX           (:guard   (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (if-zero   (force-bool   (return-inst-check-first-byte))
                            ;; check_first_byte ≡ 0
                            (vanishes!    (return-inst-exception-flag-ICPX))
                            ;; check_first_byte ≡ 1
                            (eq!          (return-inst-exception-flag-ICPX)
                                          (return-inst-MMU-success-bit))))

(defconstraint   return-inst-justifying-the-MAXCSX         (:guard   (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (if-zero   (shift   misc/OOB_FLAG   RETURN_INST_FIRST_MISC_ROW_OFFSET)
                            ;; no OOB call
                            (vanishes!   (return-inst-exception-flag-MAXCSX))
                            ;; OOB was called
                            (eq!         (return-inst-exception-flag-MAXCSX)
                                         (return-inst-OOB-max-code-size-exception))))

(defconstraint   return-inst-setting-the-gas-cost          (:guard   (return-inst-standard-scenario-row))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (if-zero   (force-bin   (return-inst-gas-cost-required))
                                         ;; we don't require the computation of gas cost
                                         (vanishes!   GAS_COST)
                                         ;; we require the computation of gas cost (either OOGX or unexceptional)
                                         (eq!   GAS_COST
                                                (+   stack/STATIC_GAS
                                                     (return-inst-MXP-memory-expansion-gas)))))

(defun   (return-inst-gas-cost-required)   (+  (return-inst-exception-flag-OOGX)
                                               (scen-RETURN-shorthand-unexceptional)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;    X.Y.4  RETURN/EXCEPTION   ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                  ;;
;;    X.Y.4  RETURN/message_call   ;;
;;                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                      ;;
;;    X.Y.4  RETURN/empty_deployment   ;;
;;                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                         ;;
;;    X.Y.4  RETURN/nonempty_deployment   ;;
;;                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

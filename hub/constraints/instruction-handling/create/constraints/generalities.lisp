(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                 ;;;;
;;;;    X.Y CREATE   ;;;;
;;;;                 ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                          ;;
;;    X.Y.9 Generalities for all CREATE's   ;;
;;                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun    (create-instruction---generic-precondition)    (*    PEEK_AT_SCENARIO    (scenario-shorthand---CREATE---sum)))

(defconstraint    create-instruction---setting-the-stack-pattern                            (:guard    (create-instruction---generic-precondition))
                  (create-stack-pattern    (create-instruction---is-CREATE2)))

(defconstraint    create-instruction---setting-the-deployment-address-stack-output          (:guard    (create-instruction---generic-precondition))
                  (begin    (eq!    (create-instruction---STACK-output-hi)    (*    (scenario-shorthand---CREATE---deployment-success)    (create-instruction---createe-address-hi)))
                            (eq!    (create-instruction---STACK-output-lo)    (*    (scenario-shorthand---CREATE---deployment-success)    (create-instruction---createe-address-lo)))
                            ))

(defconstraint    create-instruction---triggering-the-HASHINFO-lookup-and-settings          (:guard    (create-instruction---generic-precondition))
                  (maybe-request-hash   CREATE_first_stack_row___row_offset
                                        (create-instruction---trigger_HASHINFO)))

(defconstraint    create-instruction---setting-the-first-context-row                        (:guard    (create-instruction---generic-precondition))
                  (read-context-data    CREATE_current_context_row___row_offset
                                        CONTEXT_NUMBER))

(defconstraint    create-instruction---setting-the-static-exception                         (:guard    (create-instruction---generic-precondition))
                  (eq!    (create-instruction---STACK-staticx)
                          (create-instruction---current-context-is-static)))

(defconstraint    create-instruction---setting-the-module-flags-of-the-miscellaneous-row    (:guard    (create-instruction---generic-precondition))
                  (eq!    (weighted-MISC-flag-sum    CREATE_miscellaneous_row___row_offset)
                          (+    (*    MISC_WEIGHT_MMU    (create-instruction---trigger_MMU))
                                (*    MISC_WEIGHT_MXP    (create-instruction---trigger_MXP))
                                (*    MISC_WEIGHT_OOB    (create-instruction---trigger_OOB))
                                (*    MISC_WEIGHT_STP    (create-instruction---trigger_STP))
                                )))

(defconstraint    create-instruction---setting-the-MXP-instruction                          (:guard    (create-instruction---generic-precondition))
                  (if-not-zero    (shift    misc/MXP_FLAG    CREATE_miscellaneous_row___row_offset)
                                  (set-MXP-instruction-type-4    CREATE_miscellaneous_row___row_offset       ;; row offset kappa
                                                                 (create-instruction---instruction)          ;; instruction
                                                                 0                                           ;; bit modifying the behaviour of RETURN pricing
                                                                 (create-instruction---STACK-offset-hi)      ;; offset high
                                                                 (create-instruction---STACK-offset-lo)      ;; offset low
                                                                 (create-instruction---STACK-size-hi)        ;; size high
                                                                 (create-instruction---STACK-size-lo))       ;; size low
                                  ))

(defconstraint    create-instruction---setting-the-memory-expansion-exception               (:guard    (create-instruction---generic-precondition))
                  (if-zero    (shift    misc/MXP_FLAG    CREATE_miscellaneous_row___row_offset)
                              ;; MXP_FLAG  ≡  0
                              (vanishes!    (create-instruction---STACK-mxpx))
                              ;; MXP_FLAG  ≡  1
                              (eq!          (create-instruction---STACK-mxpx)
                                            (create-instruction---MXP-mxpx))
                              ))

(defconstraint    create-instruction---setting-the-STP-instruction                          (:guard    (create-instruction---generic-precondition))
                  (if-not-zero    (shift    misc/STP_FLAG    CREATE_miscellaneous_row___row_offset)
                                  (set-STP-instruction-create    CREATE_miscellaneous_row___row_offset  ;; relative row offset
                                                                 (create-instruction---instruction)     ;; instruction
                                                                 (create-instruction---STACK-value-hi)  ;; value to transfer, high part
                                                                 (create-instruction---STACK-value-lo)  ;; value to transfer, low  part
                                                                 (create-instruction---MXP-gas)         ;; memory expansion gas
                                                                 )))

(defconstraint    create-instruction---setting-the-out-of-gas-exception                     (:guard    (create-instruction---generic-precondition))
                  (if-zero    (shift    misc/STP_FLAG    CREATE_miscellaneous_row___row_offset)
                              ;; MXP_FLAG  ≡  0
                              (vanishes!    (create-instruction---STACK-oogx))
                              ;; MXP_FLAG  ≡  1
                              (eq!          (create-instruction---STACK-oogx)
                                            (create-instruction---STP-oogx))
                              ))

(defun    (create-instruction---createe-nonce)       (*    (create-instruction---trigger_RLPADDR)    (shift    account/NONCE       CREATE_first_createe_account_row___row_offset)))
(defun    (create-instruction---createe-has-code)    (*    (create-instruction---trigger_RLPADDR)    (shift    account/HAS_CODE    CREATE_first_createe_account_row___row_offset)))

(defconstraint    create-instruction---setting-the-OOB-instruction                          (:guard    (create-instruction---generic-precondition))
                  (if-not-zero    (shift    misc/OOB_FLAG    CREATE_miscellaneous_row___row_offset)
                                  (set-OOB-instruction-create    CREATE_miscellaneous_row___row_offset         ;; offset
                                                                 (create-instruction---STACK-value-hi)         ;; value    (high part)
                                                                 (create-instruction---STACK-value-lo)         ;; value    (low  part,  stack argument of CALL-type instruction)
                                                                 (create-instruction---creator-balance)        ;; balance  (from caller account)
                                                                 (create-instruction---createe-nonce)          ;; callee's nonce
                                                                 (create-instruction---createe-has-code)       ;; callee's HAS_CODE
                                                                 (create-instruction---current-context-csd)    ;; current  call  stack  depth
                                                                 )))

(defconstraint    create-instruction---setting-the-CREATE-scenario                          (:guard    (create-instruction---generic-precondition))
                  (begin
                    (eq!   scenario/CREATE_EXCEPTION    XAHOY)
                    (if-not-zero    (scenario-shorthand---CREATE---unexceptional)
                                    (begin
                                      (eq!    scenario/CREATE_ABORT                                    (create-instruction---OOB-aborting-condition))
                                      (eq!    (scenario-shorthand---CREATE---failure-condition)        (create-instruction---OOB-failure-condition) )
                                      (debug  (eq!    (scenario-shorthand---CREATE---not-rebuffed)     (-    1
                                                                                                         (create-instruction---OOB-aborting-condition)
                                                                                                         (create-instruction---OOB-failure-condition))))))
                    (if-not-zero    (scenario-shorthand---CREATE---creator-state-change)
                                    (eq!    (scenario-shorthand---CREATE---creator-state-change-will-revert)
                                            CONTEXT_WILL_REVERT))
                    (if-not-zero    (scenario-shorthand---CREATE---not-rebuffed)
                                    (eq!    (scenario-shorthand---CREATE---not-rebuffed-nonempty-init-code)
                                            (create-instruction---MXP-mtntop)))
                    (if-not-zero    (scenario-shorthand---CREATE---not-rebuffed-nonempty-init-code)
                                    (eq!    (scenario-shorthand---CREATE---deployment-failure)
                                            (shift    misc/CCSR_FLAG    CREATE_miscellaneous_row___row_offset)))
                    ))

(defconstraint    create-instruction---setting-the-MMU-instruction                          (:guard    (create-instruction---generic-precondition))
                  (if-not-zero    (shift    misc/MMU_FLAG    CREATE_miscellaneous_row___row_offset)
                                  (set-MMU-instruction-ram-to-exo-with-padding    CREATE_miscellaneous_row___row_offset               ;; offset
                                                                                  CONTEXT_NUMBER                                      ;; source ID
                                                                                  (create-instruction---tgt-id)                       ;; target ID
                                                                                  (create-instruction---aux-id)                       ;; auxiliary ID
                                                                                  ;; src_offset_hi                                       ;; source offset high
                                                                                  (create-instruction---STACK-offset-lo)              ;; source offset low
                                                                                  ;; tgt_offset_lo                                       ;; target offset low
                                                                                  (create-instruction---STACK-size-lo)                ;; size
                                                                                  ;; ref_offset                                          ;; reference offset
                                                                                  (create-instruction---STACK-size-lo)                ;; reference size
                                                                                  0                                                   ;; success bit
                                                                                  ;; limb_1                                              ;; limb 1
                                                                                  ;; limb_2                                              ;; limb 2
                                                                                  (create-instruction---exo-sum)                      ;; weighted exogenous module flag sum
                                                                                  0                                                   ;; phase
                                                                                  )))

(defun    (create-instruction---tgt-id)     (+    (*    (create-instruction---hash-init-code-and-send-to-ROM)    (create-instruction---deployment-cfi))
                                                  (*    (create-instruction---send-init-code-to-ROM)             (create-instruction---deployment-cfi))))

(defun    (create-instruction---aux-id)     (+    (*    (create-instruction---hash-init-code)                    (+    1    HUB_STAMP))
                                                  (*    (create-instruction---hash-init-code-and-send-to-ROM)    (+    1    HUB_STAMP))))

(defun    (create-instruction---exo-sum)    (+    (*    (create-instruction---hash-init-code)                                                 EXO_SUM_WEIGHT_KEC)
                                                  (*    (create-instruction---hash-init-code-and-send-to-ROM)    (+    EXO_SUM_WEIGHT_ROM     EXO_SUM_WEIGHT_KEC))
                                                  (*    (create-instruction---send-init-code-to-ROM)                   EXO_SUM_WEIGHT_ROM)))

(defconstraint    create-instruction---setting-the-next-context-number                      (:guard    (create-instruction---generic-precondition))
                  (begin
                    (if-not-zero    scenario/CREATE_EXCEPTION                                      (next-context-is-caller))
                    (if-not-zero    (scenario-shorthand---CREATE---no-context-change)                  (next-context-is-current))
                    (if-not-zero    (scenario-shorthand---CREATE---not-rebuffed-nonempty-init-code)    (next-context-is-new))))

(defconstraint    create-instruction---setting-GAS_COST                                     (:guard    (create-instruction---generic-precondition))
                  (begin
                    (if-not-zero    (+    (create-instruction---STACK-staticx)     (create-instruction---STACK-mxpx))
                                    (vanishes!    GAS_COST))
                    (if-not-zero    (+    (create-instruction---STACK-oogx)        (scenario-shorthand---CREATE---unexceptional))
                                    (eq!          GAS_COST    (+    GAS_CONST_G_CREATE
                                                                    (create-instruction---MXP-gas))))
                    ))

(defconstraint    create-instruction---setting-GAS_NEXT                                     (:guard    (create-instruction---generic-precondition))
                  (begin
                    (if-not-zero    scenario/CREATE_EXCEPTION
                                    (vanishes!    GAS_NEXT))
                    (if-not-zero    (scenario-shorthand---CREATE---no-context-change)
                                    (eq!    GAS_NEXT
                                            (-    GAS_ACTUAL
                                                  GAS_COST)))
                    (if-not-zero    (scenario-shorthand---CREATE---not-rebuffed-nonempty-init-code)
                                    (eq!    GAS_NEXT
                                            (-    GAS_ACTUAL
                                                  GAS_COST
                                                  (create-instruction---STP-gas-paid-out-of-pocket))))
                    ))

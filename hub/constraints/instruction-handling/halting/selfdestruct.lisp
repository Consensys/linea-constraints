(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                       ;;;;
;;;;    X.5 SELFDESTRUCT   ;;;;
;;;;                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           ;;
;;    X.5.1 Introduction     ;;
;;    X.5.2 Representation   ;;
;;    X.5.3 Scenario         ;;
;;                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: uncomment
(defconstraint   selfdestruct---setting-scenario-sum ()
                 (if-not-zero PEEK_AT_STACK
                              (if-not-zero stack/HALT_FLAG
                                           (if-not-zero [stack/DEC_FLAG 4]
                                                        (if-not-zero (- 1 stack/SUX stack/SOX)
                                                                     (begin
                                                                       (will-eq! PEEK_AT_SCENARIO                        1)
                                                                       (will-eq! (scenario-shorthand---SELFDESTRUCT---sum)   1)))))))

;; ""

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    X.5.4 Shorthands   ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst
  ROFF_SELFDESTRUCT___STACK_ROW                                             -1
  ROFF_SELFDESTRUCT___SCENARIO_ROW                                           0
  ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT                          1
  ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW              2
  ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW              3
  ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___ACCOUNT_DELETION_ROW   4
  ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW            4
  ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW            5
  )

(defun   (from-stack-row    col)                    (shift    col    ROFF_SELFDESTRUCT___STACK_ROW))

(defun   (selfdestruct---raw-recipient-address-hi)  (from-stack-row [stack/STACK_ITEM_VALUE_HI 1]))   ;; ""
(defun   (selfdestruct---raw-recipient-address-lo)  (from-stack-row [stack/STACK_ITEM_VALUE_LO 1]))   ;; ""
;;
(defun   (selfdestruct---is-static)                 (shift context/IS_STATIC                     ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT))
(defun   (selfdestruct---is-deployment)             (shift context/BYTE_CODE_DEPLOYMENT_STATUS   ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT))
(defun   (selfdestruct---account-address-hi)        (shift context/ACCOUNT_ADDRESS_HI            ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT))
(defun   (selfdestruct---account-address-lo)        (shift context/ACCOUNT_ADDRESS_LO            ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT))

(defun   (selfdestruct---balance)                   (shift account/BALANCE                       ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW))
(defun   (selfdestruct---is-marked)                 (shift account/MARKED_FOR_SELFDESTRUCT       ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW))
(defun   (selfdestruct---recipient-address-hi)      (shift account/ADDRESS_HI                    ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW))
(defun   (selfdestruct---recipient-address-lo)      (shift account/ADDRESS_LO                    ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW))
(defun   (selfdestruct---recipient-trm-flag)        (shift account/TRM_FLAG                      ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW))
(defun   (selfdestruct---recipient-exists)          (shift account/EXISTS                        ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW))
(defun   (selfdestruct---recipient-warmth)          (shift account/WARMTH                        ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW))

(defun   (selfdestruct---account-address-full)      (+ (* (^ 256 LLARGE) (selfdestruct---account-address-hi))   (selfdestruct---account-address-lo)  ))
(defun   (selfdestruct---recipient-address)         (+ (* (^ 256 LLARGE) (selfdestruct---recipient-address-hi)) (selfdestruct---recipient-address-lo)))  ;; ""



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;    X.5.5 Constraints   ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun   (selfdestruct---scenario-precondition) (* PEEK_AT_SCENARIO (scenario-shorthand---SELFDESTRUCT---sum)))

(defconstraint   selfdestruct---looking-back (:guard (selfdestruct---scenario-precondition))
                 (begin
                   (eq! (from-stack-row PEEK_AT_STACK    ) 1)
                   (eq! (from-stack-row stack/INSTRUCTION) EVM_INST_SELFDESTRUCT)
                   (eq! XAHOY
                        (from-stack-row    (+ stack/STATICX stack/OOGX)))))

(defconstraint   selfdestruct---setting-stack-pattern (:guard (selfdestruct---scenario-precondition))
                 (shift    (stack-pattern-1-0)    ROFF_SELFDESTRUCT___STACK_ROW))

(defconstraint   selfdestruct---setting-the-right-scenario (:guard (selfdestruct---scenario-precondition))
                 (begin
                   (eq! XAHOY scenario/SELFDESTRUCT_EXCEPTION)
                   (if-zero XAHOY
                            (begin
                              (eq! scenario/SELFDESTRUCT_WILL_REVERT             CONTEXT_WILL_REVERT)
                              (eq! (scenario-shorthand---SELFDESTRUCT---wont-revert) (- 1 CONTEXT_WILL_REVERT))))
                   (if-zero CONTEXT_WILL_REVERT
                            (begin
                              (eq! (scenario-shorthand---SELFDESTRUCT---wont-revert)    1)
                              (eq! scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED (selfdestruct---is-marked))
                              (eq! scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED (- 1 (selfdestruct---is-marked)))))))

(defconstraint   selfdestruct---setting-NSR-and-peeking-flags (:guard (selfdestruct---scenario-precondition))
                 (begin
                   (if-not-zero (from-stack-row    stack/STATICX)
                                (begin
                                  (eq! (from-stack-row    NSR) 3)
                                  (eq! (from-stack-row    NSR) (+ (shift PEEK_AT_SCENARIO    ROFF_SELFDESTRUCT___SCENARIO_ROW                 ) ;; 0
                                                                  (shift PEEK_AT_CONTEXT     ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT)
                                                                  (shift PEEK_AT_CONTEXT     2)))))
                   (if-not-zero (from-stack-row    stack/OOGX)
                                (begin
                                  (eq! (from-stack-row    NSR) 5)
                                  (eq! (from-stack-row    NSR) (+ (shift PEEK_AT_SCENARIO    ROFF_SELFDESTRUCT___SCENARIO_ROW                             ) ;; 0
                                                                  (shift PEEK_AT_CONTEXT     ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT            )
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                                                                  (shift PEEK_AT_CONTEXT     4)))))
                   (if-not-zero scenario/SELFDESTRUCT_WILL_REVERT
                                (begin
                                  (eq! (from-stack-row    NSR) 7)
                                  (eq! (from-stack-row    NSR) (+ (shift PEEK_AT_SCENARIO    ROFF_SELFDESTRUCT___SCENARIO_ROW                               ) ;; 0
                                                                  (shift PEEK_AT_CONTEXT     ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT              )
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW  )
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW  )
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW)
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW)
                                                                  (shift PEEK_AT_CONTEXT     6)))))
                   (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED
                                (begin
                                  (eq! (from-stack-row    NSR) 5)
                                  (eq! (from-stack-row    NSR) (+ (shift PEEK_AT_SCENARIO    ROFF_SELFDESTRUCT___SCENARIO_ROW                             ) ;; 0
                                                                  (shift PEEK_AT_CONTEXT     ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT            )
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                                                                  (shift PEEK_AT_CONTEXT     4)))))
                   (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED
                                (begin
                                  (eq! (from-stack-row    NSR) 6)
                                  (eq! (from-stack-row    NSR) (+ (shift PEEK_AT_SCENARIO    ROFF_SELFDESTRUCT___SCENARIO_ROW                                        ) ;; 0
                                                                  (shift PEEK_AT_CONTEXT     ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT                       )
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW           )
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW           )
                                                                  (shift PEEK_AT_ACCOUNT     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___ACCOUNT_DELETION_ROW)
                                                                  (shift PEEK_AT_CONTEXT     5)))))))

(defconstraint   selfdestruct---reading-context-data (:guard (selfdestruct---scenario-precondition))
                 (read-context-data ROFF_SELFDESTRUCT___CONTEXT_ROW___CURRENT_CONTEXT       ;; row offset
                                    CONTEXT_NUMBER))                                    ;; context to read

(defconstraint   selfdestruct---returning-empty-return-data (:guard (selfdestruct---scenario-precondition))
                 (begin
                   (if-not-zero    (from-stack-row    stack/STATICX)             (execution-provides-empty-return-data 2))
                   (if-not-zero    (from-stack-row    stack/OOGX)                (execution-provides-empty-return-data 4))
                   (if-not-zero    scenario/SELFDESTRUCT_WILL_REVERT                  (execution-provides-empty-return-data 6))
                   (if-not-zero    scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED   (execution-provides-empty-return-data 4))
                   (if-not-zero    scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED   (execution-provides-empty-return-data 5))))

(defconstraint   selfdestruct---justifying-the-static-exception (:guard (selfdestruct---scenario-precondition))
                 (eq! (from-stack-row    stack/STATICX)
                      (selfdestruct---is-static)))

(defconstraint   selfdestruct---justifying-the-gas-cost (:guard (selfdestruct---scenario-precondition))
                 (if-zero (force-bin (from-stack-row    stack/STATICX))
                          (if-zero (selfdestruct---balance)
                                   ;; account has zero balance
                                   (eq! GAS_COST
                                        (+ (from-stack-row    stack/STATIC_GAS)
                                           (* (- 1 (selfdestruct---recipient-warmth)) GAS_CONST_G_COLD_ACCOUNT_ACCESS)))
                                   ;; account has nonzero balance
                                   (eq! GAS_COST
                                        (+ (from-stack-row    stack/STATIC_GAS)
                                           (* (- 1 (selfdestruct---recipient-warmth)) GAS_CONST_G_COLD_ACCOUNT_ACCESS)
                                           (* (- 1 (selfdestruct---recipient-exists)) GAS_CONST_G_NEW_ACCOUNT        ))))))

(defconstraint   selfdestruct---generalities-for-the-first-account-row (:guard (selfdestruct---scenario-precondition))
                 (begin
                   (if-zero     (force-bin (from-stack-row    stack/STATICX))
                                (begin
                                  (debug (vanishes! (shift account/ROMLEX_FLAG  ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)))
                                  (debug (vanishes! (shift account/TRM_FLAG     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)))
                                  (eq!   (selfdestruct---account-address-hi)  (shift   account/ADDRESS_HI   ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW))
                                  (eq!   (selfdestruct---account-address-lo)  (shift   account/ADDRESS_LO   ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW))
                                  ;; balance
                                  (account-same-nonce  ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                                  (account-same-warmth ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                                  ;; code
                                  ;; depoyment
                                  ;; selfdestruct marking
                                  (DOM-SUB-stamps---standard    ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW
                                                                0)
                                  ))))

(defconstraint   selfdestruct---setting-code-and-deployment-for-the-first-account-row (:guard (selfdestruct---scenario-precondition))
                 (if-zero     (force-bin (from-stack-row    stack/STATICX))
                              (begin 
                                (if-not-zero XAHOY
                                             ;; XAHOY = 1
                                             (begin (account-same-code                                      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                                                    (account-same-deployment-number-and-status              ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW))
                                             ;; XAHOY = 0
                                             (if-zero (force-bin (selfdestruct---is-deployment))
                                                      (begin (account-same-code                             ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                                                             (account-same-deployment-number-and-status     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW))
                                                      (begin
                                                        (eq!        (shift account/CODE_SIZE_NEW            ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW) 0)
                                                        (eq!        (shift account/CODE_HASH_HI_NEW         ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW) EMPTY_KECCAK_HI)
                                                        (eq!        (shift account/CODE_HASH_LO_NEW         ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW) EMPTY_KECCAK_LO)
                                                        (debug (eq! (shift account/DEPLOYMENT_STATUS        ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW) 1))
                                                        (eq!        (shift account/DEPLOYMENT_STATUS_NEW    ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW) 0)
                                                        (account-same-deployment-number                     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)))))))

(defconstraint   selfdestruct---setting-balance-and-marked-for-SELFDESTRUCT-for-first-account-row (:guard (selfdestruct---scenario-precondition))
                 (if-zero     (force-bin (from-stack-row    stack/STATICX))
                              (begin
                                (if-not-zero (from-stack-row    stack/OOGX)
                                             (begin
                                               (account-same-balance                      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                                               (account-same-marked-for-selfdestruct      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)))
                                (if-not-zero (scenario-shorthand---SELFDESTRUCT---unexceptional)   (account-decrement-balance-by              ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW      (selfdestruct---balance)))
                                (if-not-zero scenario/SELFDESTRUCT_WILL_REVERT                     (account-same-marked-for-selfdestruct      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW))
                                (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED      (account-same-marked-for-selfdestruct      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW))
                                (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED      (account-mark-account-for-selfdestruct     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)))))

(defconstraint   selfdestruct---generalities-for-the-second-account-row (:guard (selfdestruct---scenario-precondition))
                 (begin
                   (if-zero     (force-bin (from-stack-row    stack/STATICX))
                                (begin
                                  ( debug (eq! (shift account/ROMLEX_FLAG              ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW) 0 ) )
                                  (eq!         (shift account/TRM_FLAG                 ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW) 1 )
                                  (eq!         (shift account/TRM_RAW_ADDRESS_HI       ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW) (selfdestruct---raw-recipient-address-hi))
                                  (eq!         (shift account/ADDRESS_LO               ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW) (selfdestruct---raw-recipient-address-lo))
                                  ;; balance
                                  (account-same-nonce                                  ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                                  ;; warmth
                                  (account-same-code                                   ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                                  (account-same-deployment-number-and-status           ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                                  (account-same-marked-for-selfdestruct                ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                                  (DOM-SUB-stamps---standard                           ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW 1 )))))

(defconstraint   selfdestruct---balance-and-warmth-for-second-account-row (:guard (selfdestruct---scenario-precondition))
                 (begin
                   (if-not-zero (from-stack-row    stack/OOGX)
                                (begin
                                  (account-same-balance               ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                                  (account-same-warmth                ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)))
                   (if-not-zero (scenario-shorthand---SELFDESTRUCT---unexceptional)
                                (begin
                                  (account-turn-on-warmth             ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                                  (if-eq-else (selfdestruct---account-address-full) (selfdestruct---recipient-address)
                                              ;; self destructing account address = recipient address
                                              (begin
                                                (debug (vanishes! account/BALANCE     ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW))
                                                (account-same-balance                 ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW))
                                              ;; self destructing account address ≠ recipient address
                                              (account-increment-balance-by           ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW    (selfdestruct---balance)))))))


;; (defconstraint   selfdestruct---returning-empty-return-data (:guard (selfdestruct---scenario-precondition))
;;                (begin
;;                  (if-zero     (force-bin (from-stack-row    stack/STATICX))
;;                  (if-not-zero (from-stack-row    stack/STATICX)
;;                  (if-not-zero (from-stack-row    stack/OOGX)
;;                  (if-not-zero scenario/SELFDESTRUCT_WILL_REVERT
;;                  (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED
;;                  (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED


;; (defconstraint   selfdestruct--- (:guard (selfdestruct---scenario-precondition))
;;                (begin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                               ;;
;;    X.5.6 Undoing rows for scenario/SELFDESTRUCT_WILL_REVERT   ;;
;;                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun   (selfdestruct---scenario-WILL_REVERT-precondition) (* PEEK_AT_SCENARIO
                                                               scenario/SELFDESTRUCT_WILL_REVERT))

(defconstraint   selfdestruct---first-undoing-row-for-WILL_REVERT-scenario (:guard (selfdestruct---scenario-WILL_REVERT-precondition))
                 (begin
                   (debug (eq! (shift account/ROMLEX_FLAG       ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW) 0))
                   (debug (eq! (shift account/TRM_FLAG          ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW) 0))
                   (account-same-address-as                     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                   (account-undo-balance-update                 ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                   (account-undo-nonce-update                   ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                   (account-undo-warmth-update                  ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                   (account-undo-code-update                    ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                   (account-undo-deployment-status-update       ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                   (account-same-marked-for-selfdestruct        ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW)
                   (DOM-SUB-stamps---revert-with-current        ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW 2)))

(defconstraint   selfdestruct---second-undoing-row-for-WILL_REVERT-scenario (:guard (selfdestruct---scenario-WILL_REVERT-precondition))
                 (begin
                   (debug (eq! (shift account/ROMLEX_FLAG       ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW) 0))
                   (debug (eq! (shift account/TRM_FLAG          ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW) 0))
                   (account-same-address-as                     ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                   (account-undo-balance-update                 ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                   (account-undo-nonce-update                   ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                   (account-undo-warmth-update                  ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                   (account-undo-code-update                    ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                   (account-undo-deployment-status-update       ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___DOING_ROW)
                   (account-same-marked-for-selfdestruct        ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW)
                   (DOM-SUB-stamps---revert-with-current        ROFF_SELFDESTRUCT___ACCOUNT_ROW___FOREIGN_ACCOUNT___UNDOING_ROW 2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                              ;;
;;    X.5.6 Undoing rows for scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED   ;;
;;                                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun   (selfdestruct---scenario-WONT_REVERT_NOT_YET_MARKED-precondition) (* PEEK_AT_SCENARIO
                                                                              (scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED)))

(defconstraint   selfdestruct---first-undoing-row-for-WONT_REVERT_NOT_YET_MARKED-scenario (:guard (selfdestruct---scenario-WILL_REVERT-precondition))
                 (begin
                   (debug (eq! (shift account/ROMLEX_FLAG           ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW) 0))
                   (debug (eq! (shift account/TRM_FLAG              ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW) 0))
                   (account-same-address-as                         ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___DOING_ROW)
                   (eq!        (shift account/BALANCE_NEW           ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW) 0)
                   (eq!        (shift account/NONCE_NEW             ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW) 0)
                   (account-same-warmth                             ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW)
                   (eq!        (shift account/CODE_SIZE_NEW         ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW) 0)
                   (eq!        (shift account/CODE_HASH_HI_NEW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW) EMPTY_KECCAK_HI)
                   (eq!        (shift account/CODE_HASH_LO_NEW      ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW) EMPTY_KECCAK_LO)
                   (shift      (eq!   account/DEPLOYMENT_NUMBER_NEW (+ 1 account/DEPLOYMENT_NUMBER))                   ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW)
                   (shift      (eq!   account/DEPLOYMENT_STATUS_NEW 0                              )                   ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW)
                   (account-same-marked-for-selfdestruct            ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW)
                   (selfdestruct-dom-sub-stamps                     ROFF_SELFDESTRUCT___ACCOUNT_ROW___CURRENT_ACCOUNT___UNDOING_ROW)))

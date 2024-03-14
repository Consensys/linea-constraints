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
(defconstraint setting-SELFDESTRUCT-scenario-sum ()
               (if-not-zero PEEK_AT_STACK
                            (if-not-zero stack/HALT_FLAG
                                         (if-not-zero [stack/DEC_FLAG 4]
                                                      (if-not-zero (- 1 stack/SUX stack/SOX)
                                                                   (begin
                                                                     (will-eq! PEEK_AT_SCENARIO                        1)
                                                                     (will-eq! (scenario-shorthand-SELFDESTRUCT-sum)   1)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    X.5.4 Shorthands   ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst
  sd-first-context-row-offset                 1
  sd-first-account-row-offset                 2
  sd-second-account-row-offset                3
  sd-first-account-row-undoing-offset         4
  sd-second-account-row-undoing-offset 5
  sd-account-deletion-row-offset              4
  )

;; TODO: uncomment
(defun (sd-raw-recipient-address-hi)  (shift [stack/STACK_ITEM_VALUE_HI 1] -1))
(defun (sd-raw-recipient-address-lo)  (shift [stack/STACK_ITEM_VALUE_LO 1] -1))
;;
(defun (sd-is-static)          (shift context/IS_STATIC                   sd-first-context-row-offset))
(defun (sd-is-deployment)      (shift context/BYTE_CODE_DEPLOYMENT_STATUS sd-first-context-row-offset))
(defun (sd-account-address-hi) (shift context/ACCOUNT_ADDRESS_HI          sd-first-context-row-offset))
(defun (sd-account-address-lo) (shift context/ACCOUNT_ADDRESS_LO          sd-first-context-row-offset))
(defun (sd-account-address)    (+ (* (^ 256 LLARGE) (sd-account-address-hi)) (sd-account-address-lo)))
;;
(defun (sd-balance)                   (shift account/BALANCE                 sd-first-account-row-offset))
(defun (sd-is-marked)                 (shift account/MARKED_FOR_SELFDESTRUCT sd-first-account-row-offset))
;;
(defun (sd-recipient-address-hi)      (shift account/ADDRESS_HI sd-second-account-row-offset))
(defun (sd-recipient-address-lo)      (shift account/ADDRESS_LO sd-second-account-row-offset))
(defun (sd-recipient-address)         (+ (* (^ 256 LLARGE) (sd-recipient-address-hi)) (sd-recipient-address-lo)))
(defun (sd-recipient-trm-flag)        (shift account/TRM_FLAG sd-second-account-row-offset))
(defun (sd-recipient-exists)          (shift account/EXISTS   sd-second-account-row-offset))
(defun (sd-recipient-warmth)          (shift account/WARMTH   sd-second-account-row-offset))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;    X.5.5 Constraints   ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (selfdestruct-scenario-precondition) (* PEEK_AT_SCENARIO (scenario-shorthand-SELFDESTRUCT-sum)))

(defconstraint selfdestruct-looking-back (:guard (selfdestruct-scenario-precondition))
               (begin
                 (eq! (prev PEEK_AT_STACK) 1)
                 (eq! (prev stack/INSTRUCTION) EVM_INST_SELFDESTRUCT)
                 (eq! XAHOY (prev (+ stack/STATICX stack/OOGX)))))

(defconstraint selfdestruct-setting-stack-pattern (:guard (selfdestruct-scenario-precondition))
               (prev (stack-pattern-1-0)))

(defconstraint selfdestruct-setting-refund (:guard (selfdestruct-scenario-precondition))
               (eq! REFGAS_NEW (+ REFGAS
                                  (* REFUND_CONST_R_SELFDESTRUCT scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED))))

(defconstraint selfdestruct-setting-the-right-scenario (:guard (selfdestruct-scenario-precondition))
               (begin
                 (eq! XAHOY scenario/SELFDESTRUCT_EXCEPTION)
                 (if-zero XAHOY
                          (begin
                            (eq! scenario/SELFDESTRUCT_WILL_REVERT         CONTEXT_WILL_REVERT)
                            (eq! (scenario-shorthand-SELFDESTRUCT-wont-revert) (- 1 CONTEXT_WILL_REVERT))))
                 (if-zero CONTEXT_WILL_REVERT
                          (begin
                            (eq! (scenario-shorthand-SELFDESTRUCT-wont-revert) 1)
                            (eq! scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED (sd-is-marked))
                            (eq! scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED (- 1 (sd-is-marked)))))))

(defconstraint selfdestruct-setting-NSR-and-peeking-flags (:guard (selfdestruct-scenario-precondition))
               (begin
                 (if-not-zero (prev stack/STATICX)
                              (begin
                                (eq! (prev NSR) 3)
                                (eq! (prev NSR) (+ (shift PEEK_AT_SCENARIO 0)
                                                   (shift PEEK_AT_CONTEXT  1)
                                                   (shift PEEK_AT_CONTEXT  2)))))
                 (if-not-zero (prev stack/OOGX)
                              (begin
                                (eq! (prev NSR) 5)
                                (eq! (prev NSR) (+ (shift PEEK_AT_SCENARIO 0)
                                                   (shift PEEK_AT_CONTEXT  1)
                                                   (shift PEEK_AT_ACCOUNT  2)
                                                   (shift PEEK_AT_ACCOUNT  3)
                                                   (shift PEEK_AT_CONTEXT  4)))))
                 (if-not-zero scenario/SELFDESTRUCT_WILL_REVERT
                              (begin
                                (eq! (prev NSR) 7)
                                (eq! (prev NSR) (+ (shift PEEK_AT_SCENARIO 0)
                                                   (shift PEEK_AT_CONTEXT  1)
                                                   (shift PEEK_AT_ACCOUNT  2)
                                                   (shift PEEK_AT_ACCOUNT  3)
                                                   (shift PEEK_AT_ACCOUNT  4)
                                                   (shift PEEK_AT_ACCOUNT  5)
                                                   (shift PEEK_AT_CONTEXT  6)))))
                 (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED
                              (begin
                                (eq! (prev NSR) 5)
                                (eq! (prev NSR) (+ (shift PEEK_AT_SCENARIO 0)
                                                   (shift PEEK_AT_CONTEXT  1)
                                                   (shift PEEK_AT_ACCOUNT  2)
                                                   (shift PEEK_AT_ACCOUNT  3)
                                                   (shift PEEK_AT_CONTEXT  4)))))
                 (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED
                              (begin
                                (eq! (prev NSR) 6)
                                (eq! (prev NSR) (+ (shift PEEK_AT_SCENARIO 0)
                                                   (shift PEEK_AT_CONTEXT  1)
                                                   (shift PEEK_AT_ACCOUNT  2)
                                                   (shift PEEK_AT_ACCOUNT  3)
                                                   (shift PEEK_AT_ACCOUNT  4)
                                                   (shift PEEK_AT_CONTEXT  5)))))))

(defconstraint selfdestruct-reading-context-data (:guard (selfdestruct-scenario-precondition))
               (read-context-data
                 sd-first-context-row-offset        ;; row offset
                 CONTEXT_NUMBER))                   ;; context to read


(defconstraint selfdestruct-returning-empty-return-data (:guard (selfdestruct-scenario-precondition))
               (begin
                 (if-not-zero (prev stack/STATICX)                             (execution-provides-empty-return-data 2))
                 (if-not-zero (prev stack/OOGX)                                (execution-provides-empty-return-data 4))
                 (if-not-zero scenario/SELFDESTRUCT_WILL_REVERT                (execution-provides-empty-return-data 6))
                 (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED (execution-provides-empty-return-data 4))
                 (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED (execution-provides-empty-return-data 5))))

(defconstraint selfdestruct-justifying-the-static-exception (:guard (selfdestruct-scenario-precondition))
               (eq! (prev stack/STATICX) (sd-is-static)))

(defconstraint selfdestruct-justifying-the-gas-cost (:guard (selfdestruct-scenario-precondition))
               (if-zero (force-bin (prev stack/STATICX))
                        (if-zero (sd-balance)
                                 ;; account has zero balance
                                 (eq! GAS_COST
                                      (+ GAS_CONST_G_SELFDESTRUCT
                                         (* (- 1 (sd-recipient-warmth)) GAS_CONST_G_COLD_ACCOUNT_ACCESS)))
                                 ;; account has nonzero balance
                                 (eq! GAS_COST
                                      (+ GAS_CONST_G_SELFDESTRUCT
                                         (* (- 1 (sd-recipient-warmth)) GAS_CONST_G_COLD_ACCOUNT_ACCESS)
                                         (* (- 1 (sd-recipient-exists)) GAS_CONST_G_NEW_ACCOUNT        ))))))

(defconstraint selfdestruct-generalities-for-the-first-account-row (:guard (selfdestruct-scenario-precondition))
               (begin
                 (if-zero     (force-bin (prev stack/STATICX))
                              (begin
                                (debug (vanishes! (shift account/ROM_LEX_FLAG sd-first-account-row-offset)))
                                (debug (vanishes! (shift account/TRM_FLAG     sd-first-account-row-offset)))
                                (eq!   (sd-account-address-hi)  (shift account/ADDRESS_HI sd-first-account-row-offset))
                                (eq!   (sd-account-address-lo)  (shift account/ADDRESS_LO sd-first-account-row-offset))
                                ;; balance
                                (account-same-nonce             sd-first-account-row-offset)
                                (account-same-warmth            sd-first-account-row-offset)
                                ;; code
                                ;; depoyment
                                ;; selfdestruct marking
                                (standard-dom-sub-stamps sd-first-account-row-offset
                                                         0                           )))))

(defconstraint selfdestruct-setting-code-and-deployment-for-the-first-account-row (:guard (selfdestruct-scenario-precondition))
               (if-zero     (force-bin (prev stack/STATICX))
                            (begin 
                              (if-not-zero XAHOY
                                           ;; XAHOY = 1
                                           (begin (account-same-code                             sd-first-account-row-offset)
                                                  (account-same-deployment-number-and-status     sd-first-account-row-offset))
                                           ;; XAHOY = 0
                                           (if-zero (force-bin (sd-is-deployment))
                                                    (begin (account-same-code                             sd-first-account-row-offset)
                                                           (account-same-deployment-number-and-status     sd-first-account-row-offset))
                                                    (begin
                                                      (eq!        (shift account/CODE_SIZE_NEW               sd-first-account-row-offset) 0)
                                                      (eq!        (shift account/CODE_HASH_HI_NEW            sd-first-account-row-offset) EMPTY_KECCAK_HI)
                                                      (eq!        (shift account/CODE_HASH_LO_NEW            sd-first-account-row-offset) EMPTY_KECCAK_LO)
                                                      (debug (eq! (shift account/DEPLOYMENT_STATUS           sd-first-account-row-offset) 1))
                                                      (eq!        (shift account/DEPLOYMENT_STATUS_NEW       sd-first-account-row-offset) 0)
                                                      (account-same-deployment-number                        sd-first-account-row-offset)))))))

(defconstraint selfdestruct-setting-balance-and-marked-for-SELFDESTRUCT-for-first-account-row (:guard (selfdestruct-scenario-precondition))
               (if-zero     (force-bin (prev stack/STATICX))
                            (begin
                              (if-not-zero (prev stack/OOGX)
                                           (begin
                                             (account-same-balance                      sd-first-account-row-offset)
                                             (account-same-marked-for-selfdestruct      sd-first-account-row-offset)))
                              (if-not-zero (scenario-shorthand-SELFDESTRUCT-unexceptional)     (account-decrement-balance-by              sd-first-account-row-offset      (sd-balance)))
                              (if-not-zero scenario/SELFDESTRUCT_WILL_REVERT                   (account-same-marked-for-selfdestruct      sd-first-account-row-offset))
                              (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED    (account-same-marked-for-selfdestruct      sd-first-account-row-offset))
                              (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED    (account-mark-account-for-selfdestruct     sd-first-account-row-offset)))))

(defconstraint selfdestruct-generalities-for-the-second-account-row (:guard (selfdestruct-scenario-precondition))
               (begin
                 (if-zero     (force-bin (prev stack/STATICX))
                              (begin
                                ( debug (eq! (shift account/ROM_LEX_FLAG             sd-second-account-row-offset) 0 ) )
                                (eq!         (shift account/TRM_FLAG                 sd-second-account-row-offset) 1 )
                                (eq!         (shift account/TRM_RAW_ADDRESS_HI       sd-second-account-row-offset) (sd-raw-recipient-address-hi))
                                (eq!         (shift account/ADDRESS_LO               sd-second-account-row-offset) (sd-raw-recipient-address-lo))
                                ;; balance
                                (account-same-nonce                                  sd-second-account-row-offset)
                                ;; warmth
                                (account-same-code                                   sd-second-account-row-offset)
                                (account-same-deployment-number-and-status           sd-second-account-row-offset)
                                (account-same-marked-for-selfdestruct                sd-second-account-row-offset)
                                (standard-dom-sub-stamps                             sd-second-account-row-offset 1 )))))

(defconstraint selfdestruct-balance-and-warmth-for-second-account-row (:guard (selfdestruct-scenario-precondition))
               (begin
                 (if-not-zero (prev stack/OOGX)
                              (begin
                                (account-same-balance               sd-second-account-row-offset)
                                (account-same-warmth                sd-second-account-row-offset)))
                 (if-not-zero (scenario-shorthand-SELFDESTRUCT-unexceptional)
                              (begin
                                (account-turn-on-warmth             sd-second-account-row-offset)
                                (if-eq-else (sd-account-address) (sd-recipient-address)
                                            ;; self destructing account address = recipient address
                                            (begin
                                              (debug (vanishes! account/BALANCE     sd-second-account-row-offset))
                                              (account-same-balance                 sd-second-account-row-offset))
                                            ;; self destructing account address ≠ recipient address
                                            (account-increment-balance-by           sd-second-account-row-offset    (sd-balance)))))))


;; (defconstraint selfdestruct-returning-empty-return-data (:guard (selfdestruct-scenario-precondition))
;;                (begin
;;                  (if-zero     (force-bin (prev stack/STATICX))
;;                  (if-not-zero (prev stack/STATICX)
;;                  (if-not-zero (prev stack/OOGX)
;;                  (if-not-zero scenario/SELFDESTRUCT_WILL_REVERT
;;                  (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED
;;                  (if-not-zero scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED


;; (defconstraint selfdestruct- (:guard (selfdestruct-scenario-precondition))
;;                (begin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                               ;;
;;    X.5.6 Undoing rows for scenario/SELFDESTRUCT_WILL_REVERT   ;;
;;                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (selfdestruct-scenario-WILL_REVERT-precondition) (* PEEK_AT_SCENARIO
                                                           scenario/SELFDESTRUCT_WILL_REVERT))

(defconstraint selfdestruct-first-undoing-row-for-WILL_REVERT-scenario (:guard (selfdestruct-scenario-WILL_REVERT-precondition))
               (begin
                 (debug (eq! (shift account/ROM_LEX_FLAG      sd-first-account-row-undoing-offset) 0))
                 (debug (eq! (shift account/TRM_FLAG          sd-first-account-row-undoing-offset) 0))
                 (account-same-address-as                     sd-first-account-row-undoing-offset      sd-first-account-row-offset)
                 (account-undo-balance-update                 sd-first-account-row-undoing-offset      sd-first-account-row-offset)
                 (account-undo-nonce-update                   sd-first-account-row-undoing-offset      sd-first-account-row-offset)
                 (account-undo-warmth-update                  sd-first-account-row-undoing-offset      sd-first-account-row-offset)
                 (account-undo-code-update                    sd-first-account-row-undoing-offset      sd-first-account-row-offset)
                 (account-undo-deployment-status-update       sd-first-account-row-undoing-offset      sd-first-account-row-offset)
                 (account-same-marked-for-selfdestruct        sd-first-account-row-undoing-offset)
                 (revert-dom-sub-stamps                       sd-first-account-row-undoing-offset 2)))

(defconstraint selfdestruct-second-undoing-row-for-WILL_REVERT-scenario (:guard (selfdestruct-scenario-WILL_REVERT-precondition))
               (begin
                 (debug (eq! (shift account/ROM_LEX_FLAG      sd-second-account-row-undoing-offset) 0))
                 (debug (eq! (shift account/TRM_FLAG          sd-second-account-row-undoing-offset) 0))
                 (account-same-address-as                     sd-second-account-row-undoing-offset      sd-second-account-row-offset)
                 (account-undo-balance-update                 sd-second-account-row-undoing-offset      sd-second-account-row-offset)
                 (account-undo-nonce-update                   sd-second-account-row-undoing-offset      sd-second-account-row-offset)
                 (account-undo-warmth-update                  sd-second-account-row-undoing-offset      sd-second-account-row-offset)
                 (account-undo-code-update                    sd-second-account-row-undoing-offset      sd-second-account-row-offset)
                 (account-undo-deployment-status-update       sd-second-account-row-undoing-offset      sd-second-account-row-offset)
                 (account-same-marked-for-selfdestruct        sd-second-account-row-undoing-offset)
                 (revert-dom-sub-stamps                       sd-second-account-row-undoing-offset 2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                              ;;
;;    X.5.6 Undoing rows for scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED   ;;
;;                                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (selfdestruct-scenario-WONT_REVERT_NOT_YET_MARKED-precondition) (* PEEK_AT_SCENARIO
                                                                          (scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED)))

(defconstraint selfdestruct-first-undoing-row-for-WONT_REVERT_NOT_YET_MARKED-scenario (:guard (selfdestruct-scenario-WILL_REVERT-precondition))
               (begin
                 (debug (eq! (shift account/ROM_LEX_FLAG          sd-first-account-row-undoing-offset) 0))
                 (debug (eq! (shift account/TRM_FLAG              sd-first-account-row-undoing-offset) 0))
                 (account-same-address-as                         sd-first-account-row-undoing-offset      sd-first-account-row-offset)
                 (eq!        (shift account/BALANCE_NEW           sd-first-account-row-undoing-offset) 0)
                 (eq!        (shift account/NONCE_NEW             sd-first-account-row-undoing-offset) 0)
                 (account-same-warmth                             sd-first-account-row-undoing-offset)
                 (eq!        (shift account/CODE_SIZE_NEW         sd-first-account-row-undoing-offset) 0)
                 (eq!        (shift account/CODE_HASH_HI_NEW      sd-first-account-row-undoing-offset) EMPTY_KECCAK_HI)
                 (eq!        (shift account/CODE_HASH_LO_NEW      sd-first-account-row-undoing-offset) EMPTY_KECCAK_LO)
                 (shift      (eq!   account/DEPLOYMENT_NUMBER_NEW (+ 1 account/DEPLOYMENT_NUMBER))         sd-first-account-row-undoing-offset)
                 (shift      (eq!   account/DEPLOYMENT_STATUS_NEW 0                                )       sd-first-account-row-undoing-offset)
                 (account-same-marked-for-selfdestruct            sd-first-account-row-undoing-offset)
                 (selfdestruct-dom-sub-stamps                     sd-first-account-row-undoing-offset)))

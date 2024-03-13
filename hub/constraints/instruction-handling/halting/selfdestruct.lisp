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

;; ;; TODO: uncomment
;; (defconstraint setting-SELFDESTRUCT-scenario-sum ()
;;                (if-not-zero PEEK_AT_STACK
;;                             (if-not-zero stack/HALT_FLAG
;;                                          (if-not-zero [stack/DEC_FLAG 4]
;;                                                       (if-not-zero (- 1 stack/SUX stack/SOX)
;;                                                                    (begin
;;                                                                      (will-eq! PEEK_AT_SCENARIO                    1)
;;                                                                      (will-eq! (scen-shorthand-SELFDESTRUCT-sum)   1)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    X.5.4 Shorthands   ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst
  firstContextRow         1
  firstAccountRow         2
  secondAccountRow        3
  firstUndoingAccountRow  4
  secondUndoingAccountRow 5
  selfdestructAccountRow  4
  )

;; ;; TODO: uncomment
;; (defun (selfdestruct-raw-recipient-address-hi)  (shift ([stack/STACK_ITEM_VALUE_HI 1] -1))
;; (defun (selfdestruct-raw-recipient-address-lo)  (shift ([stack/STACK_ITEM_VALUE_LO 1] -1))
;;
;; (defun (selfdestruct-is-static)                 (shift context/IS_STATIC          firstContextRow))
;; (defun (selfdestruct-account-address-hi)        (shift context/ACCOUNT_ADDRESS_HI firstContextRow))
;; (defun (selfdestruct-account-address-lo)        (shift context/ACCOUNT_ADDRESS_LO firstContextRow))
;; (defun (selfdestruct-account-address)           (+ (* (^ 256 LLARGE) (selfdestruct-account-address-hi)) (selfdestruct-account-address-lo)))
;;
;; (defun (selfdestruct-balance)                   (shift account/BALANCE                 firstAccountRow))
;; (defun (selfdestruct-is-marked)                 (shift account/MARKED_FOR_SELFDESTRUCT firstAccountRow))
;;
;; (defun (selfdestruct-recipient-address-hi)      (shift account/ADDRESS_HI secondAccountRow))
;; (defun (selfdestruct-recipient-address-lo)      (shift account/ADDRESS_LO secondAccountRow))
;; (defun (selfdestruct-recipient-address)         (+ (* (^ 256 LLARGE) (selfdestruct-recipient-address-hi)) (selfdestruct-recipient-address-lo)))
;; (defun (selfdestruct-recipient-trm-flag)        (shift account/TRM_FLAG secondAccountRow))
;; (defun (selfdestruct-recipient-exists)          (shift account/EXISTS   secondAccountRow))
;; (defun (selfdestruct-recipient-warmth)          (shift account/WARMTH   secondAccountRow))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;    X.5.5 Constraints   ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (selfdestruct-standard-precondition) (* PEEK_AT_SCENARIO (scen-shorthand-SELFDESTRUCT-sum)))

(defconstraint selfdestruct-looking-back (:guard (selfdestruct-standard-precondition))
               (begin
                 (eq! (prev PEEK_AT_STACK) 1)
                 (eq! (prev stack/INSTRUCTION) EVM_INST_SELFDESTRUCT)
                 (eq! XAHOY (prev (+ stack/STATICX stack/OOGX)))))

(defconstraint selfdestruct-setting-stack-pattern (:guard (selfdestruct-standard-precondition))
               (prev (stack-pattern-1-0)))

(defconstraint selfdestruct-setting-refund-update (:guard (selfdestruct-standard-precondition))
               (eq! REFGAS_NEW (+ REFGAS
                                  (* REFUND_CONST_R_SELFDESTRUCT scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED))))


;; (defconstraint selfdestruct- (:guard (selfdestruct-standard-precondition))
;;                (begin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                               ;;
;;    X.5.6 Undoing rows for scenario/SELFDESTRUCT_WILL_REVERT   ;;
;;                                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                              ;;
;;    X.5.6 Undoing rows for scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED   ;;
;;                                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

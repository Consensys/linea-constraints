(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                           ;;
;;   10.2 SCEN/CALL instruction shorthands   ;;
;;                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;  CALL/externally_owned_account
(defun (scen-shorthand-CALL-externally-owned-account)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/smart_contract
(defun (scen-shorthand-CALL-smart-contract)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/precompile
(defun (scen-shorthand-CALL-precompile)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    scenario/CALL_PRC_FAILURE
    scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/entry
(defun (scen-shorthand-CALL-entry)
  (+ 
    (scen-shorthand-CALL-externally-owned-account)
    (scen-shorthand-CALL-smart-contract)
    (scen-shorthand-CALL-precompile)
    ))

;;  CALL/unexceptional
(defun (scen-shorthand-CALL-unexceptional)
  (+ 
    scenario/CALL_ABORT
    (scen-shorthand-CALL-entry)
    ))

;;  CALL/sum
(defun (scen-shorthand-CALL-sum)
  (+ 
    scenario/CALL_EXCEPTION
    (scen-shorthand-CALL-unexceptional)
    ))

;;  CALL/no_precompile
(defun (scen-shorthand-CALL-no-precompile)
  (+ 
    scenario/CALL_EXCEPTION
    scenario/CALL_ABORT
    (scen-shorthand-CALL-externally-owned-account)
    (scen-shorthand-CALL-smart-contract)
    ))

;;  CALL/precompile_success
(defun (scen-shorthand-CALL-precompile-success)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/execution_known_to_revert
(defun (scen-shorthand-CALL-execution-known-to-revert)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/execution_known_to_not_revert
(defun (scen-shorthand-CALL-execution-known-to-not-revert)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/success
(defun (scen-shorthand-CALL-success)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/smc_success
(defun (scen-shorthand-CALL-smc-success)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/smc_failure
(defun (scen-shorthand-CALL-smc-failure)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/failure
(defun (scen-shorthand-CALL-failure)
  (+ 
    (scen-shorthand-CALL-smc-failure)
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    scenario/CALL_PRC_FAILURE
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/no_context_change
(defun (scen-shorthand-CALL-no-context-change)
  (+ 
    ;; scenario/CALL_EXCEPTION
    scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    (scen-shorthand-CALL-externally-owned-account)
    (scen-shorthand-CALL-precompile)
    ))

;;  CALL/requires_both_accounts_twice
(defun (scen-shorthand-CALL-requires-both-accounts-twice)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/requires_balance_update
(defun (scen-shorthand-CALL-requires-balance-update)
  (+ 
    (scen-shorthand-CALL-externally-owned-account)
    (scen-shorthand-CALL-smart-contract)
    (scen-shorthand-CALL-precompile-success)
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/undoes_balance_update_with_failure
(defun (scen-shorthand-CALL-undoes-balance-update-with-failure)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;;  CALL/undoes_balance_update_with_revert
(defun (scen-shorthand-CALL-undoes-balance-update-with-revert)
  (+ 
    ;; scenario/CALL_EXCEPTION
    ;; scenario/CALL_ABORT
    scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
    scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
    ;; scenario/CALL_PRC_FAILURE
    scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
    ;; scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
    ))

;; ;;  CALL/
;; (defun (scen-shorthand-CALL-)
;;   (+ 
;;     scenario/CALL_EXCEPTION
;;     scenario/CALL_ABORT
;;     scenario/CALL_EOA_SUCCESS_CALLER_WILL_REVERT
;;     scenario/CALL_EOA_SUCCESS_CALLER_WONT_REVERT
;;     scenario/CALL_SMC_FAILURE_CALLER_WILL_REVERT
;;     scenario/CALL_SMC_FAILURE_CALLER_WONT_REVERT
;;     scenario/CALL_SMC_SUCCESS_CALLER_WILL_REVERT
;;     scenario/CALL_SMC_SUCCESS_CALLER_WONT_REVERT
;;     scenario/CALL_PRC_FAILURE
;;     scenario/CALL_PRC_SUCCESS_CALLER_WILL_REVERT
;;     scenario/CALL_PRC_SUCCESS_CALLER_WONT_REVERT
;;     ))

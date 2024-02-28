(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                             ;;
;;   10.2 SCEN/CREATE instruction shorthands   ;;
;;                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  CREATE/failure_condition
(defun (scen-shorthand-CREATE-failure-condition)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))

;;  CREATE/execution_will_revert
(defun (scen-shorthand-CREATE-execution-will-revert)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))

;;  CREATE/execution_wont_revert
(defun (scen-shorthand-CREATE-execution-wont-revert)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))

;;  CREATE/empty_init_code
(defun (scen-shorthand-CREATE-empty-init-code)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))

;;  CREATE/nonempty_init_code
(defun (scen-shorthand-CREATE-nonempty-init-code)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))

;;  CREATE/execution
(defun (scen-shorthand-CREATE-execution)
  (+ 
    (scen-shorthand-CREATE-nonempty-init-code)
    (scen-shorthand-CREATE-empty-init-code)
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))

;;  CREATE/undo_account_operations
(defun (scen-shorthand-CREATE-undo-account-operations)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))

;;  CREATE/compute_deployment_address
(defun (scen-shorthand-CREATE-compute-deployment-address)
  (+ 
    (scen-shorthand-CREATE-failure-condition)
    (scen-shorthand-CREATE-execution)
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))

;;  CREATE/unexceptional
(defun (scen-shorthand-CREATE-unexceptional)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    (scen-shorthand-CREATE-failure-condition)
    (scen-shorthand-CREATE-execution)
    ))

;;  CREATE/sum
(defun (scen-shorthand-CREATE-sum)
  (+ 
    scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    (scen-shorthand-CREATE-unexceptional)
    ))

;;  CREATE/no_context_change
(defun (scen-shorthand-CREATE-no-context-change)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    (scen-shorthand-CREATE-failure-condition)
    (scen-shorthand-CREATE-empty-init-code)
    ))

;;  CREATE/deployment_success
(defun (scen-shorthand-CREATE-deployment-success)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))

;;  CREATE/deployment_failure
(defun (scen-shorthand-CREATE-deployment-failure)
  (+ 
    ;; scenario/CREATE_EXCEPTION
    ;; scenario/CREATE_ABORT
    ;; scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
    ;; scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
    ;; scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
    scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
    ;; scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
    ))


;; ;;  CREATE/
;; (defun (scen-shorthand-CREATE-)
;;   (+ 
;;     scenario/CREATE_EXCEPTION
;;     scenario/CREATE_ABORT
;;     scenario/CREATE_FAILURE_CONDITION_WILL_REVERT
;;     scenario/CREATE_FAILURE_CONDITION_WONT_REVERT
;;     scenario/CREATE_EMPTY_INIT_CODE_WILL_REVERT
;;     scenario/CREATE_EMPTY_INIT_CODE_WONT_REVERT
;;     scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WILL_REVERT
;;     scenario/CREATE_NONEMPTY_INIT_CODE_FAILURE_WONT_REVERT
;;     scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WILL_REVERT
;;     scenario/CREATE_NONEMPTY_INIT_CODE_SUCCESS_WONT_REVERT
;;     ))

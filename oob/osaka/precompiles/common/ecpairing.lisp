(module oob)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;; 4.4 For ECPAIRING     ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (prc-ecpairing---standard-precondition)                    IS_ECPAIRING)
(defun (prc-ecpairing---remainder)                                (shift OUTGOING_RES_LO 2))
(defun (prc-ecpairing---is-multiple_PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING)           (shift OUTGOING_RES_LO 3))
(defun (prc-ecpairing---insufficient-gas)                         (shift OUTGOING_RES_LO 4))
(defun (prc-ecpairing---precompile-cost_PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING)       (*    (prc-ecpairing---is-multiple_PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING)
                                                                  (+ (* GAS_CONST_ECPAIRING PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING) (* GAS_CONST_ECPAIRING_PAIR (prc---cds)))))

(defconstraint prc-ecpairing---mod-cds-by-PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING (:guard (* (assumption---fresh-new-stamp) (prc-ecpairing---standard-precondition)))
  (call-to-MOD 2 0 (prc---cds) 0 PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING))

(defconstraint prc-ecpairing---check-remainder-is-zero (:guard (* (assumption---fresh-new-stamp) (prc-ecpairing---standard-precondition)))
  (call-to-ISZERO 3 0 (prc-ecpairing---remainder)))

(defconstraint prc-ecpairing---compare-call-gas-against-precompile-cost (:guard (* (assumption---fresh-new-stamp) (prc-ecpairing---standard-precondition)))
  (if-zero (prc-ecpairing---is-multiple_PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING)
           (noCall 4)
           (begin (vanishes! (shift ADD_FLAG 4))
                  (vanishes! (shift MOD_FLAG 4))
                  (eq! (shift WCP_FLAG 4) 1)
                  (vanishes! (shift BLS_REF_TABLE_FLAG 4))
                  (eq! (shift OUTGOING_INST 4) EVM_INST_LT)
                  (vanishes! (shift [OUTGOING_DATA 1] 4))
                  (eq! (shift [OUTGOING_DATA 2] 4) (prc---callee-gas))
                  (vanishes! (shift [OUTGOING_DATA 3] 4))
                  (eq! (* (shift [OUTGOING_DATA 4] 4) PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING)
                       (prc-ecpairing---precompile-cost_PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING)))))

(defconstraint prc-ecpairing---justify-hub-predictions (:guard (* (assumption---fresh-new-stamp) (prc-ecpairing---standard-precondition)))
  (begin (eq! (prc---hub-success)
              (* (prc-ecpairing---is-multiple_PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING) (- 1 (prc-ecpairing---insufficient-gas))))
         (if-zero (prc---hub-success)
                  (vanishes! (prc---return-gas))
                  (eq! (* (prc---return-gas) PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING)
                       (- (* (prc---callee-gas) PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING) (prc-ecpairing---precompile-cost_PRECOMPILE_CALL_DATA_UNIT_SIZE___ECPAIRING))))))

(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                               ;;;;
;;;;    X.5 Instruction handling   ;;;;
;;;;                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                        ;;
;;    X.5.27 Machine state instructions   ;;
;;                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (machine-state-instruction-no-stack-exception)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;
  (* PEEK_AT_STACK
     stack/MACHINE_STATE_FLAG
     (- 1 stack/SUX stack/SOX)))

(defun (machine-state-DEC_FLAG-sum) (+ [ stack/DEC_FLAG 1 ]
                                       [ stack/DEC_FLAG 2 ]
                                       [ stack/DEC_FLAG 3 ]))

(defconstraint machine-state-setting-the-stack-pattern (:guard (machine-state-instruction-no-stack-exception))
               (begin
                 (if-not-zero (machine-state-DEC_FLAG-sum) (stack-pattern-0-1))
                 (if-not-zero [ stack/DEC_FLAG 4 ]         (stack-pattern-0-0))))

;; TODO: finish
;; (defconstraint machine-state-setting-NSR               (:guard (machine-state-instruction-no-stack-exception))
;;                (eq! NSR
;;                     (+ stack/MXP_FLAG CMC))
;; (defconstraint machine-state-setting-peeking-flags     (:guard (machine-state-instruction-no-stack-exception))
;; (defconstraint machine-state-setting-gas-cost          (:guard (machine-state-instruction-no-stack-exception))
;; (defconstraint machine-state-setting-stack-value       (:guard (machine-state-instruction-no-stack-exception))

;; (defconstraint machine-state- (:guard (machine-state-instruction-no-stack-exception))

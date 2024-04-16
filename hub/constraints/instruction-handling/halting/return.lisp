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

;; (defun  (return-inst-standard-stack-hypothesis)  (*  PEEK_AT_STACK
;;                                                 stack/HALT_FLAG
;;                                                 [ stack/DEC_FLAG 1 ]
;;                                                 (-  1  stack/SUX )))
;;
;; (defun  (return-inst-standard-scenario-row)  (* PEEK_AT_SCENARIO
;;                                                 (scen-RETURN-shorthand-sum)))

(defconstraint return-inst-  (:guard  (return-inst-standard-scenario-row))

(defconstraint return-inst-  (:guard  (return-inst-standard-scenario-row))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;    X.Y.3 Shorthands   ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (return-inst-instruction) (shift  stack/INSTRUCTION  -1))
;; (defun (return-inst-offset-hi)   (shift  [ stack/STACK_ITEM_VALUE_HI 1]  -1))
;; (defun (return-inst-offset-lo)   (shift  [ stack/STACK_ITEM_VALUE_LO 1]  -1))
;; (defun (return-inst-size-hi)     (shift  [ stack/STACK_ITEM_VALUE_HI 2]  -1))
;; (defun (return-inst-size-lo)     (shift  [ stack/STACK_ITEM_VALUE_LO 2]  -1))
(defun (return-inst-code-hash-hi    )
(defun (return-inst-code-hash-lo)
(defun (return-inst-deployment-address-hi)
(defun (return-inst-deployment-address-lo)
(defun (return-inst-is-root)
(defun (return-inst-is-deployment)
(defun (return-inst-return-at-offset)
(defun (return-inst-return-at-capacity)
(defun (return-inst-MXP-may-trigger-non-trivial-operation)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;    X.Y.4 Generalities   ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconstraint return-inst-acceptable-exceptions  (:guard  (return-inst-standard-scenario-row))

(defconstraint return-inst-setting-stack-pattern  (:guard  (return-inst-standard-scenario-row))

(defconstraint return-inst-setting-peeking-flags  (:guard  (return-inst-standard-scenario-row))

(defconstraint return-inst-first-context-row  (:guard  (return-inst-standard-scenario-row))

(defconstraint return-inst-refining-the-return-scenario  (:guard  (return-inst-standard-scenario-row))

(defun (return-inst-trigger_MXP)                     (1)) ;;                             does this syntax make sense ?
(defun (return-inst-trigger_OOB)                     (+  (return-inst-check-first-byte) (return-inst-write-return-data-to-caller-ram)))
(defun (return-inst-check-first-byte)                (+  
(defun (return-inst-write-return-data-to-caller-ram)
(defun (return-inst-trigger_MMU)
(defun (return-inst-trigger_HASHINFO)

(defconstraint return-inst-setting-the-first-misc-row  (:guard  (return-inst-standard-scenario-row))


(defconstraint return-inst-triggering-HASHINFO  (:guard  (return-inst-standard-scenario-row))
(defconstraint return-inst-setting-MXP-data  (:guard  (return-inst-standard-scenario-row))
(defconstraint return-inst-setting-OOB-data  (:guard  (return-inst-standard-scenario-row))
(defconstraint return-inst-setting-MMU-data-first-call  (:guard  (return-inst-standard-scenario-row))
(defconstraint return-inst-justifying-the-MXPX  (:guard  (return-inst-standard-scenario-row))
(defconstraint return-inst-justifying-the-ICPX  (:guard  (return-inst-standard-scenario-row))
(defconstraint return-inst-justifying-the-MAXCSX  (:guard  (return-inst-standard-scenario-row))
(defconstraint return-inst-setting-the-gas-cost  (:guard  (return-inst-standard-scenario-row))



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

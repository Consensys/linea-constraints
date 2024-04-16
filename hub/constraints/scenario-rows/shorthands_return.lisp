(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                             ;;
;;   10.2 SCEN/RETURN instruction shorthands   ;;
;;                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;  RETURN/message_call
(defun (scen-RETURN-shorthand-message-call)
  (+ ;; scenario/RETURN_EXCEPTION
     scenario/RETURN_FROM_MESSAGE_CALL_WILL_TOUCH_RAM
     scenario/RETURN_FROM_MESSAGE_CALL_WONT_TOUCH_RAM
     ;; scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WILL_REVERT
     ;; scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WONT_REVERT
     ;; scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WILL_REVERT
     ;; scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WONT_REVERT
     ))

;; ;;  RETURN/empty_deployment
(defun (scen-RETURN-shorthand-empty-deployment)
  (+ ;; scenario/RETURN_EXCEPTION
     ;; scenario/RETURN_FROM_MESSAGE_CALL_WILL_TOUCH_RAM
     ;; scenario/RETURN_FROM_MESSAGE_CALL_WONT_TOUCH_RAM
     scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WILL_REVERT
     scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WONT_REVERT
     ;; scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WILL_REVERT
     ;; scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WONT_REVERT
     ))

;; ;;  RETURN/nonempty_deployment
(defun (scen-RETURN-shorthand-nonempty-deployment)
  (+ ;; scenario/RETURN_EXCEPTION
     ;; scenario/RETURN_FROM_MESSAGE_CALL_WILL_TOUCH_RAM
     ;; scenario/RETURN_FROM_MESSAGE_CALL_WONT_TOUCH_RAM
     ;; scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WILL_REVERT
     ;; scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WONT_REVERT
     scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WILL_REVERT
     scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WONT_REVERT
     ))

;; ;;  RETURN/deployment
(defun (scen-RETURN-shorthand-deployment)
  (+ (scen-RETURN-shorthand-empty-deployment)
     (scen-RETURN-shorthand-nonempty-deployment)))

;; ;;  RETURN/deployment_will_revert
(defun (scen-RETURN-shorthand-deployment-will-revert)
  (+ ;; scenario/RETURN_EXCEPTION
     ;; scenario/RETURN_FROM_MESSAGE_CALL_WILL_TOUCH_RAM
     ;; scenario/RETURN_FROM_MESSAGE_CALL_WONT_TOUCH_RAM
     scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WILL_REVERT
     ;; scenario/RETURN_FROM_DEPLOYMENT_EMPTY_CODE_WONT_REVERT
     scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WILL_REVERT
     ;; scenario/RETURN_FROM_DEPLOYMENT_NONEMPTY_CODE_WONT_REVERT
     ))

;; ;; NOT A CONSTRAINT
;; (defconstraint  BULLSHIT-making-sure-everything-compiles-scen-RETURN-shorthands () 
;;                (begin  (vanishes! (scen-RETURN-shorthand-message-call)           )
;;                        (vanishes! (scen-RETURN-shorthand-empty-deployment)       )
;;                        (vanishes! (scen-RETURN-shorthand-nonempty-deployment)    )
;;                        (vanishes! (scen-RETURN-shorthand-deployment)             )
;;                        (vanishes! (scen-RETURN-shorthand-deployment-will-revert) )
;;                        (vanishes! (scen-RETURN-shorthand-unexceptional)          )
;;                        (vanishes! (scen-RETURN-shorthand-sum)                    )))

;; ;;  RETURN/unexceptional
(defun (scen-RETURN-shorthand-unexceptional)
  (+ (scen-RETURN-shorthand-message-call)
     (scen-RETURN-shorthand-deployment)))

;; ;;  RETURN/sum
(defun (scen-RETURN-shorthand-sum)
  (+ scenario/RETURN_EXCEPTION
     (scen-RETURN-shorthand-unexceptional)))

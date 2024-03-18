(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                          ;;
;;   4.3 Revert data specific constraints   ;;
;;                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                ;;
;;   4.3.2 Generalities and setting CN_WILL_REV   ;;
;;                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;; should be redundant
;; (defconstraint binary-constraints-for-cn-revert-flags ()
;;                (begin
;;                  (debug (is-binary CN_WILL_REV))
;;                  (is-binary CN_GETS_REV)
;;                  (is-binary CN_SELF_REV)))

(defconstraint revert-flag-vanishing ()
               (if-zero TX_EXEC
                        (vanishes! (+ CN_GETS_REV CN_SELF_REV))))

(defconstraint computing-CN_WILL_REV-as-a-disjunction ()
               (eq! CN_WILL_REV
                    (- (+ CN_GETS_REV CN_SELF_REV)
                       (* CN_GETS_REV CN_SELF_REV))))

(defconstraint rev-stamp-vanishes-if-the-context-doenst-get-reverted ()
               (if-zero CN_WILL_REV
                        (vanishes! CN_REV_STAMP)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;   4.3.3 Setting CN_SELF_REV   ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun (self_revert_trigger) (- (+ XAHOY (* stack/HALT_FLAG [stack/DEC_FLAG 2]))
                                (* XAHOY    stack/HALT_FLAG [stack/DEC_FLAG 2])))

(defconstraint recording-self-induced-revert (:perspective stack)
               (if-not-zero (force-bool (self_revert_trigger))
                            (begin
                              (eq! CN_SELF_REV 1)
                              (eq! CN_REV_STAMP HUB_STAMP))))

(defconstraint recording-unexceptional-halting-instruction (:perspective stack)
               (if-not-zero HALT_FLAG
                            (if-zero (force-bool (self_revert_trigger))
                                     (vanishes! CN_SELF_REV))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               ;;
;;   4.3.4 Setting CN_GETS_REV   ;;
;;                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint root-context-does-not-get-reverted ()
               (if-not-zero (prev TX_INIT)
                            (if-not-zero TX_EXEC
                                         (vanishes! CN_GETS_REV))))

(defconstraint child-context-inherits-parent-rollback ()
               (if-not-zero (remained-constant! HUB_STAMP)
                            (if-not-zero (prev TX_EXEC)
                                         (if-not-zero TX_EXEC
                                                      (if-eq (prev CONTEXT_NUMBER_NEW) HUB_STAMP
                                                             (begin
                                                               (eq! CN_GETS_REV (prev CN_WILL_REV))
                                                               (if-zero CN_SELF_REV (remained-constant! CN_REV_STAMP))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                     ;;
;;   4.3.5 Special purpose constants   ;;
;;                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconst
  hub_tau                8      ;; for height increments
  hub_lambda            16      ;; for dom/sub stamp business
  epsilon_revert         8
  epsilon_selfdestruct  12)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                         ;;
;;   4.3.6 Special DOM / SUB constraints   ;;
;;                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun (zero-dom-sub-stamps relOffset) (begin
                                         (vanishes! (shift DOM_STAMP relOffset))
                                         (vanishes! (shift SUB_STAMP relOffset))))

(defun (standard-dom-sub-stamps relOffset d) (begin
                                               (eq!       (shift DOM_STAMP relOffset) (+ (* hub_lambda HUB_STAMP) d))
                                               (vanishes! (shift SUB_STAMP relOffset)                               )))

(defun (undoing-dom-sub-stamps relOffset rho epsilon s) (begin
                                                          (eq!  (shift DOM_STAMP relOffset)  (+ (* hub_lambda rho      ) epsilon))
                                                          (eq!  (shift SUB_STAMP relOffset)  (+ (* hub_lambda HUB_STAMP) s      ))))

(defun (revert-dom-sub-stamps relOffset s) (undoing-dom-sub-stamps 
                                             relOffset
                                             CN_REV_STAMP
                                             epsilon_revert
                                             s))

(defun (child-context-reverts-dom-sub-stamps relOffset s child_rev_stamp) (undoing-dom-sub-stamps
                                                                            relOffset
                                                                            child_rev_stamp
                                                                            epsilon_revert
                                                                            s))

(defun (selfdestruct-dom-sub-stamps relOffset) (undoing-dom-sub-stamps
                                                 relOffset
                                                 TX_END_STAMP
                                                 epsilon_selfdestruct
                                                 0))
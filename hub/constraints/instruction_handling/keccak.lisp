(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                               ;;;;
;;;;    X.5 Instruction handling   ;;;;
;;;;                               ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;
;;                    ;;
;;    X.5.10 Keccak   ;;
;;                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;;  Shorthands  ;;
;;;;;;;;;;;;;;;;;;

(defun (keccak-offset-hi)      ((nth stack/STACK_ITEM_VALUE_HI 1)))
(defun (keccak-offset-lo)      ((nth stack/STACK_ITEM_VALUE_LO 1)))
(defun (keccak-size-hi)        ((nth stack/STACK_ITEM_VALUE_HI 2)))
(defun (keccak-size-lo)        ((nth stack/STACK_ITEM_VALUE_LO 2)))
(defun (keccak-result-hi)      ((nth stack/STACK_ITEM_VALUE_HI 4)))
(defun (keccak-result-lo)      ((nth stack/STACK_ITEM_VALUE_LO 4)))
(defun (keccak-mxpx)           (next (misc/MXP_MXPX)))
(defun (keccak-mxp-gas)        (next (misc/MXP_GAS_MXP)))
(defun (keccak-mxp-MTNTOP)     (next (misc/MXP_MTNTOP)))

(defun (keccak-trigger-MMU)
  (* (- 1 XAHOY)
     (keccak-mxp-MTNTOP)))


(defun (keccak-no-stack-exceptions)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (* PEEK_AT_STACK
     stack/KEC_FLAG
     (- 1 stack/SUX stack/SOX)))

(defconstraint keccak-stack-pattern (:guard (keccak-no-stack-exceptions))
               (stack-pattern-2-1))

(defconstraint keccak-NSR-and-peeking-flags (:guard (keccak-no-stack-exceptions))
               (begin
                 (eq! NON_STACK_ROWS
                      (+ 1 CONTEXT_MAY_CHANGE_FLAG))
                 (eq! NON_STACK_ROWS
                      (+ (shift PEEK_AT_MISCELLANEOUS 1)
                         (* (shift PEEK_AT_CONTEXT    2) CONTEXT_MAY_CHANGE_FLAG )))))

(defconstraint keccak-MISC-flags (:guard (keccak-no-stack-exceptions))
               (eq! (weighted-MISC-flag-sum 1)
                    (+ MISC_MXP_WEIGHT
                       (* MISC_MMU_WEIGHT (keccak-trigger-MMU))))

;; (defconstraint keccak- (:guard (keccak-no-stack-exceptions))
;; (weighted-MISC-flag-sum 1)

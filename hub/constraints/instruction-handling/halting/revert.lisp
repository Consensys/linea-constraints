(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                 ;;;;
;;;;    X.5 REVERT   ;;;;
;;;;                 ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         ;;
;;    X.5.1 Introduction   ;;
;;    X.5.2 Shorthands     ;;
;;                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconst
  ROW_OFFSET_REVERT_MISCELLANEOUS_ROW     1
  ROW_OFFSET_REVERT_CURRENT_CONTEXT_ROW   2
  ROW_OFFSET_REVERT_CALLER_CONTEXT_ROW    3)



;; (defun  (revert-inst-instruction)                stack/INSTRUCTION)
;; (defun  (revert-inst-offset-hi)                  [ stack/STACK_ITEM_VALUE_HI 1 ])
;; (defun  (revert-inst-offset-lo)                  [ stack/STACK_ITEM_VALUE_LO 1 ])
;; (defun  (revert-inst-size-hi)                    [ stack/STACK_ITEM_VALUE_HI 2 ])
;; (defun  (revert-inst-size-lo)                    [ stack/STACK_ITEM_VALUE_LO 2 ])
;; (defun  (revert-inst-current-context)            CONTEXT_NUMBER)
;; (defun  (revert-inst-caller-context)             CALLER_CONTEXT_NUMBER)
;; (defun  (revert-inst-MXP-memory-expansion-gas)   (shift  misc/MXP_GAS_MXP             ROW_OFFSET_REVERT_MISCELLANEOUS_ROW))
;; (defun  (revert-inst-r@o)                        (shift  context/RETURN_AT_OFFSET     ROW_OFFSET_REVERT_CURRENT_CONTEXT_ROW))
;; (defun  (revert-inst-r@c)                        (shift  context/RETURN_AT_CAPACITY   ROW_OFFSET_REVERT_CURRENT_CONTEXT_ROW))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        ;;
;;    X.5.1 Constraints   ;;
;;                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun  (revert-inst-standard-precondition)  (*  PEEK_AT_STACK
                                                 stack/HALT_FLAG
                                                 [ stack/DEC_FLAG  2 ]
                                                 (-  1  stack/SUX  stack/SOX )))

(defconstraint  revert-inst-setting-the-stack-pattern                     (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-allowable-exceptions                          (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-setting-NSR                                   (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-setting-the-peeking-flags                     (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-setting-the-context-rows                      (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-setting-the-miscellaneous-row-module-flags    (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-setting-the-MXP-data                          (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-setting-the-MXPX                              (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-setting-trigger_MMU                           (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-setting-the-MMU-data                          (:guard (revert-inst-standard-precondition))
(defconstraint  revert-inst-setting-the-gas-cost                          (:guard (revert-inst-standard-precondition))

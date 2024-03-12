(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                          ;;
;;   10.5 SCEN/PRC instruction shorthands   ;;
;;                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  SELFDESTRUCT/wont_revert
(defun (scen-shorthand-SELFDESTRUCT-wont-revert)
  (+ SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED
     SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED))

;;  SELFDESTRUCT/unexceptional
(defun (scen-shorthand-SELFDESTRUCT-unexceptional)
  (+ SELFDESTRUCT_WILL_REVERT
     (scen-shorthand-SELFDESTRUCT-wont-revert)))

;;  SELFDESTRUCT/sum
(defun (scen-shorthand-SELFDESTRUCT-sum)
  (+ SELFDESTRUCT_EXCEPTION
    (scen-shorthand-SELFDESTRUCT-unexceptional)))

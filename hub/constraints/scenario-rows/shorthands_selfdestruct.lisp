(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                          ;;
;;   10.5 SCEN/PRC instruction shorthands   ;;
;;                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  SELFDESTRUCT/wont_revert
(defun (scen-shorthand-SELFDESTRUCT-wont-revert) (+ scenario/SELFDESTRUCT_WONT_REVERT_ALREADY_MARKED
                                                    scenario/SELFDESTRUCT_WONT_REVERT_NOT_YET_MARKED))

;;  SELFDESTRUCT/unexceptional
(defun (scen-shorthand-SELFDESTRUCT-unexceptional) (+ scenario/SELFDESTRUCT_WILL_REVERT
                                                      (scen-shorthand-SELFDESTRUCT-wont-revert)))

;;  SELFDESTRUCT/sum
(defun (scen-shorthand-SELFDESTRUCT-sum) (+ scenario/SELFDESTRUCT_EXCEPTION
                                            (scen-shorthand-SELFDESTRUCT-unexceptional)))

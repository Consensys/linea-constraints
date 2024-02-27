(defun (add-activation-flag)
  (and (unexceptional-stack-row) hub.stack/ADD_FLAG))

(deflookup 
  hub-into-add
  ;; target columns
  (
    add.ARG_1_HI
    add.ARG_1_LO
    add.ARG_2_HI
    add.ARG_2_LO
    add.RES_HI
    add.RES_LO
    add.INST
  )
  ;; source columns
  (
    (* [hub.stack/STACK_ITEM_VALUE_HI 1] (add-activation-flag)) ;; arg1

    (* [hub.stack/STACK_ITEM_VALUE_LO 1] (add-activation-flag))
    (* [hub.stack/STACK_ITEM_VALUE_HI 2] (add-activation-flag)) ;; arg2

    (* [hub.stack/STACK_ITEM_VALUE_LO 2] (add-activation-flag))
    (* [hub.stack/STACK_ITEM_VALUE_HI 4] (add-activation-flag)) ;; res

    (* [hub.stack/STACK_ITEM_VALUE_LO 4] (add-activation-flag))
    (* hub.stack/INSTRUCTION (add-activation-flag))
  ))



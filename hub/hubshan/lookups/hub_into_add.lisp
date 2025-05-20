(defun (hub-into-add-activation-flag)
  (* (unexceptional-stack-row) hubshan.stack/ADD_FLAG))

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
    (* [hubshan.stack/STACK_ITEM_VALUE_HI 1] (hub-into-add-activation-flag)) ;; arg1
    (* [hubshan.stack/STACK_ITEM_VALUE_LO 1] (hub-into-add-activation-flag))
    (* [hubshan.stack/STACK_ITEM_VALUE_HI 2] (hub-into-add-activation-flag)) ;; arg2
    (* [hubshan.stack/STACK_ITEM_VALUE_LO 2] (hub-into-add-activation-flag))
    (* [hubshan.stack/STACK_ITEM_VALUE_HI 4] (hub-into-add-activation-flag)) ;; result
    (* [hubshan.stack/STACK_ITEM_VALUE_LO 4] (hub-into-add-activation-flag))
    (* hubshan.stack/INSTRUCTION             (hub-into-add-activation-flag)) ;; instruction
  ))



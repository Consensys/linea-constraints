(defun (hub-into-add-activation-flag-shan)
  (* (unexceptional-stack-row-shan) hubshan.stack/ADD_FLAG))

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
    (* [hubshan.stack/STACK_ITEM_VALUE_HI 1] (hub-into-add-activation-flag-shan)) ;; arg1
    (* [hubshan.stack/STACK_ITEM_VALUE_LO 1] (hub-into-add-activation-flag-shan))
    (* [hubshan.stack/STACK_ITEM_VALUE_HI 2] (hub-into-add-activation-flag-shan)) ;; arg2
    (* [hubshan.stack/STACK_ITEM_VALUE_LO 2] (hub-into-add-activation-flag-shan))
    (* [hubshan.stack/STACK_ITEM_VALUE_HI 4] (hub-into-add-activation-flag-shan)) ;; result
    (* [hubshan.stack/STACK_ITEM_VALUE_LO 4] (hub-into-add-activation-flag-shan))
    (* hubshan.stack/INSTRUCTION             (hub-into-add-activation-flag-shan)) ;; instruction
  ))



(defun (hub-into-mul-activation-flag-shan)
  (* (unexceptional-stack-row-shan)
      hubshan.stack/MUL_FLAG))

(deflookup hub-into-mul
    ;; target columns
    (
        mul.ARG_1_HI
        mul.ARG_1_LO
        mul.ARG_2_HI
        mul.ARG_2_LO
        mul.RES_HI
        mul.RES_LO
        mul.INST
    )
    ;; source columns
    (
        (* [hubshan.stack/STACK_ITEM_VALUE_HI 1]     (hub-into-mul-activation-flag-shan))   ;; arg1
        (* [hubshan.stack/STACK_ITEM_VALUE_LO 1]     (hub-into-mul-activation-flag-shan))
        (* [hubshan.stack/STACK_ITEM_VALUE_HI 2]     (hub-into-mul-activation-flag-shan))   ;; arg2
        (* [hubshan.stack/STACK_ITEM_VALUE_LO 2]     (hub-into-mul-activation-flag-shan))
        (* [hubshan.stack/STACK_ITEM_VALUE_HI 4]     (hub-into-mul-activation-flag-shan))   ;; res
        (* [hubshan.stack/STACK_ITEM_VALUE_LO 4]     (hub-into-mul-activation-flag-shan))
        (*  hubshan.stack/INSTRUCTION                (hub-into-mul-activation-flag-shan))
    )
)

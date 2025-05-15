(defun (hub-into-mod-activation-flag)
  (* (unexceptional-stack-row)
      hubshan.stack/MOD_FLAG))

(deflookup hub-into-mod
    ;; target columns
    (
        mod.ARG_1_HI
        mod.ARG_1_LO
        mod.ARG_2_HI
        mod.ARG_2_LO
        mod.RES_HI
        mod.RES_LO
        mod.INST
    )
    ;; source columns
    (
        (* [hubshan.stack/STACK_ITEM_VALUE_HI 1]     (hub-into-mod-activation-flag))   ;; arg1
        (* [hubshan.stack/STACK_ITEM_VALUE_LO 1]     (hub-into-mod-activation-flag))
        (* [hubshan.stack/STACK_ITEM_VALUE_HI 2]     (hub-into-mod-activation-flag))   ;; arg2
        (* [hubshan.stack/STACK_ITEM_VALUE_LO 2]     (hub-into-mod-activation-flag))
        (* [hubshan.stack/STACK_ITEM_VALUE_HI 4]     (hub-into-mod-activation-flag))   ;; res
        (* [hubshan.stack/STACK_ITEM_VALUE_LO 4]     (hub-into-mod-activation-flag))
        (*  hubshan.stack/INSTRUCTION                (hub-into-mod-activation-flag))
    )
)

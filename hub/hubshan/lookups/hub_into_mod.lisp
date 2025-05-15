(defun (hub-into-mod-activation-flag-shan)
  (* (unexceptional-stack-row-shan)
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
        (* [hubshan.stack/STACK_ITEM_VALUE_HI 1]     (hub-into-mod-activation-flag-shan))   ;; arg1
        (* [hubshan.stack/STACK_ITEM_VALUE_LO 1]     (hub-into-mod-activation-flag-shan))
        (* [hubshan.stack/STACK_ITEM_VALUE_HI 2]     (hub-into-mod-activation-flag-shan))   ;; arg2
        (* [hubshan.stack/STACK_ITEM_VALUE_LO 2]     (hub-into-mod-activation-flag-shan))
        (* [hubshan.stack/STACK_ITEM_VALUE_HI 4]     (hub-into-mod-activation-flag-shan))   ;; res
        (* [hubshan.stack/STACK_ITEM_VALUE_LO 4]     (hub-into-mod-activation-flag-shan))
        (*  hubshan.stack/INSTRUCTION                (hub-into-mod-activation-flag-shan))
    )
)

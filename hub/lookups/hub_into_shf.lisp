(defun (shf-activation-flag)
  (and (unexceptional-stack-row)
       hub.stack/SHF_FLAG))

(deflookup hub-into-shf
    ;; target columns
    (
        shf.ARG_1_HI
        shf.ARG_1_LO
        shf.ARG_2_HI
        shf.ARG_2_LO
        shf.RES_HI
        shf.RES_LO
        shf.INST
    )
    ;; source columns
    (
        (* [hub.stack/STACK_ITEM_VALUE_HI 1]     (shf-activation-flag))
        (* [hub.stack/STACK_ITEM_VALUE_LO 1]     (shf-activation-flag))
        (* [hub.stack/STACK_ITEM_VALUE_HI 2]     (shf-activation-flag))
        (* [hub.stack/STACK_ITEM_VALUE_LO 2]     (shf-activation-flag))
        (* [hub.stack/STACK_ITEM_VALUE_HI 4]     (shf-activation-flag))
        (* [hub.stack/STACK_ITEM_VALUE_LO 4]     (shf-activation-flag))
        (*  hub.stack/INSTRUCTION                (shf-activation-flag))
    )
)

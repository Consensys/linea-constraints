(defun (hub-into-clz-activation-flag)
  (* (unexceptional-stack-row)
      hub.stack/BIN_FLAG
      [hub.stack/DEC_FLAG 3]))

(defclookup (hub-into-clz :unchecked)
  ;; target columns
  (
   log2.arg
   0
  log2.clz
  )
  ;; source selector
  (hub-into-clz-activation-flag)
  ;; source columns
  (
    (:: [hub.stack/STACK_ITEM_VALUE_HI 1]    [hub.stack/STACK_ITEM_VALUE_LO 1])
   [hub.stack/STACK_ITEM_VALUE_HI 4]
   [hub.stack/STACK_ITEM_VALUE_LO 4]

  )
)
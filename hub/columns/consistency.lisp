(module hub)

(defcolumns
  ( perm_account_ADDRESS_FIRST          :binary )
  ( perm_account_ADDRESS_AGAIN          :binary )
  ( perm_account_ABS_TX_NUM_FIRST       :binary )
  ( perm_account_ABS_TX_NUM_AGAIN       :binary )
  ( perm_context_CN_FIRST               :binary )
  ( perm_context_CN_AGAIN               :binary )
  ( perm_stack_CONTEXT_FIRST            :binary ) ;; 4 times longer than standard HUB columns
  ( perm_stack_CONTEXT_AGAIN            :binary ) ;; 4 times longer than standard HUB columns
  ( perm_stack_HEIGHT_FIRST             :binary ) ;; 4 times longer than standard HUB columns
  ( perm_stack_HEIGHT_AGAIN             :binary ) ;; 4 times longer than standard HUB columns
  ( perm_stack_SAME_SPOT_FIRST          :binary ) ;; 4 times longer than standard HUB columns
  ( perm_stack_SAME_SPOT_AGAIN          :binary ) ;; 4 times longer than standard HUB columns
  )

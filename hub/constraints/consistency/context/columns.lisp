(module hub)

(defcolumns
  ;; context consistency permutation related 
  ( con_FIRST :binary@prove )
  ( con_AGAIN :binary@prove )
  )

(defpermutation
    ;; permuted columns
    ;;;;;;;;;;;;;;;;;;;
  (
      perm_context_PEEK_AT_CONTEXT
      perm_context_CONTEXT_NUMBER
      perm_context_HUB_STAMP
      perm_context_CALL_STACK_DEPTH
      perm_context_IS_ROOT
      perm_context_IS_STATIC
      perm_context_ACCOUNT_ADDRESS_HI
      perm_context_ACCOUNT_ADDRESS_LO
      perm_context_ACCOUNT_DEPLOYMENT_NUMBER
      perm_context_BYTE_CODE_ADDRESS_HI
      perm_context_BYTE_CODE_ADDRESS_LO
      perm_context_BYTE_CODE_DEPLOYMENT_NUMBER
      perm_context_BYTE_CODE_DEPLOYMENT_STATUS
      perm_context_BYTE_CODE_CODE_FRAGMENT_INDEX
      perm_context_CALL_DATA_CONTEXT_NUMBER
      perm_context_CALLER_ADDRESS_HI
      perm_context_CALLER_ADDRESS_LO
      perm_context_CALL_VALUE
      perm_context_CALL_DATA_OFFSET
      perm_context_CALL_DATA_SIZE
      perm_context_RETURN_AT_OFFSET
      perm_context_RETURN_AT_CAPACITY
      perm_context_UPDATE
      perm_context_RETURN_DATA_OFFSET
      perm_context_RETURN_DATA_SIZE
      perm_context_RETURN_DATA_CONTEXT_NUMBER
  )
  ;; original columns
  ;;;;;;;;;;;;;;;;;;;
  (
    (+ PEEK_AT_CONTEXT)
    (+ context/CONTEXT_NUMBER)
    (+ HUB_STAMP)
    context/CALL_STACK_DEPTH
    context/IS_ROOT
    context/IS_STATIC
    context/ACCOUNT_ADDRESS_HI
    context/ACCOUNT_ADDRESS_LO
    context/ACCOUNT_DEPLOYMENT_NUMBER
    context/BYTE_CODE_ADDRESS_HI
    context/BYTE_CODE_ADDRESS_LO
    context/BYTE_CODE_DEPLOYMENT_NUMBER
    context/BYTE_CODE_DEPLOYMENT_STATUS
    context/BYTE_CODE_CODE_FRAGMENT_INDEX
    context/CALL_DATA_CONTEXT_NUMBER
    context/CALLER_ADDRESS_HI
    context/CALLER_ADDRESS_LO
    context/CALL_VALUE
    context/CALL_DATA_OFFSET
    context/CALL_DATA_SIZE
    context/RETURN_AT_OFFSET
    context/RETURN_AT_CAPACITY
    context/UPDATE
    context/RETURN_DATA_OFFSET
    context/RETURN_DATA_SIZE
    context/RETURN_DATA_CONTEXT_NUMBER
  )
)

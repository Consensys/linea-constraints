(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                          ;;
;;    X.3 Context consistency constraints   ;;
;;                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint perm-cn-first-and-cn-again-constraints ()
               (begin
                 (eq!   (+    con_AGAIN    con_FIRST) 
                        perm_context_PEEK_AT_CONTEXT)
                 (if-zero    (force-bool perm_context_PEEK_AT_CONTEXT)
                             (eq! (next con_FIRST)
                                  (next perm_context_PEEK_AT_CONTEXT)))
                 (if-not-zero  perm_context_PEEK_AT_CONTEXT
                               (if-not-zero (next    perm_context_PEEK_AT_CONTEXT)
                                            (if-not-zero    (will-remain-constant!   perm_context_CONTEXT_NUMBER)
                                                            (will-eq! con_FIRST 1)
                                                            (will-eq! con_AGAIN 1))))))

(defconstraint context-data-immutability ()
               (if-not-zero (next con_AGAIN)
                            (begin
                              ( will-remain-constant!  perm_context_CALL_DATA_CONTEXT_NUMBER      )
                              ( will-remain-constant!  perm_context_CALL_STACK_DEPTH              )
                              ( will-remain-constant!  perm_context_IS_ROOT                       )
                              ( will-remain-constant!  perm_context_IS_STATIC                     )
                              ( will-remain-constant!  perm_context_ACCOUNT_ADDRESS_HI            )
                              ( will-remain-constant!  perm_context_ACCOUNT_ADDRESS_LO            )
                              ( will-remain-constant!  perm_context_ACCOUNT_DEPLOYMENT_NUMBER     )
                              ( will-remain-constant!  perm_context_BYTE_CODE_ADDRESS_HI          )
                              ( will-remain-constant!  perm_context_BYTE_CODE_ADDRESS_LO          )
                              ( will-remain-constant!  perm_context_BYTE_CODE_DEPLOYMENT_NUMBER   )
                              ( will-remain-constant!  perm_context_BYTE_CODE_DEPLOYMENT_STATUS   )
                              ( will-remain-constant!  perm_context_BYTE_CODE_CODE_FRAGMENT_INDEX )
                              ( will-remain-constant!  perm_context_CALLER_ADDRESS_HI             )
                              ( will-remain-constant!  perm_context_CALLER_ADDRESS_LO             )
                              ( will-remain-constant!  perm_context_CALL_VALUE                    )
                              ( will-remain-constant!  perm_context_CALL_DATA_OFFSET              )
                              ( will-remain-constant!  perm_context_CALL_DATA_SIZE                )
                              ( will-remain-constant!  perm_context_RETURN_AT_OFFSET              )
                              ( will-remain-constant!  perm_context_RETURN_AT_CAPACITY            ))))

(defconstraint context-data-return-data-constancy ()
               (if-not-zero (next con_AGAIN)
                            (if-zero (force-bool (next perm_context_UPDATE))
                                     (begin
                                       ( will-remain-constant!  perm_context_RETURN_DATA_CONTEXT_NUMBER )
                                       ( will-remain-constant!  perm_context_RETURN_DATA_OFFSET         )
                                       ( will-remain-constant!  perm_context_RETURN_DATA_SIZE           )))))

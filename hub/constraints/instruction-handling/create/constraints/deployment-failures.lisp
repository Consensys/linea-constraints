(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                 ;;;;
;;;;    X.Y CREATE   ;;;;
;;;;                 ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                         ;;
;;    X.Y.14 Deployment failure CREATE's   ;;
;;                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun    (create-instruction---deployment-failure-precondition)    (*    PEEK_AT_SCENARIO    (scenario-shorthand---CREATE---deployment-failure)))

(defconstraint    create-instruction---undoing-creator-account-operations-for-deployment-failures    (:guard    (create-instruction---deployment-failure-precondition))
                  (begin
                    (account-same-address-as                         CREATE_second_creator_account_row___row_offset    CREATE_first_creator_account_row___row_offset)
                    (account-undo-balance-update                     CREATE_second_creator_account_row___row_offset    CREATE_first_creator_account_row___row_offset)
                    (account-same-nonce                              CREATE_second_creator_account_row___row_offset)
                    (account-same-code                               CREATE_second_creator_account_row___row_offset)
                    (account-same-warmth                             CREATE_second_creator_account_row___row_offset)
                    (account-same-deployment-number-and-status       CREATE_second_creator_account_row___row_offset)
                    (account-same-marked-for-selfdestruct            CREATE_second_creator_account_row___row_offset)
                    (vanishes!    (shift    account/TRM_FLAG         CREATE_second_creator_account_row___row_offset))
                    (vanishes!    (shift    account/ROMLEX_FLAG      CREATE_second_creator_account_row___row_offset))
                    (vanishes!    (shift    account/RLPADDR_FLAG     CREATE_second_creator_account_row___row_offset))    ;; TODO: these 3 bit vanishing constraints could be merged
                    (revert-with-child-failure-dom-sub-stamps        CREATE_second_creator_account_row___row_offset    0    (create-instruction---createe-revert-stamp))
                    ))

(defconstraint    create-instruction---undoing-createe-account-operations-for-deployment-failures    (:guard    (create-instruction---deployment-failure-precondition))
                  (begin
                    (account-same-address-as                         CREATE_second_createe_account_row___row_offset    CREATE_first_createe_account_row___row_offset)
                    (account-undo-balance-update                     CREATE_second_createe_account_row___row_offset    CREATE_first_createe_account_row___row_offset)
                    (account-undo-nonce-update                       CREATE_second_createe_account_row___row_offset    CREATE_first_createe_account_row___row_offset)
                    (account-undo-code-update                        CREATE_second_createe_account_row___row_offset    CREATE_first_createe_account_row___row_offset)
                    (account-same-warmth                             CREATE_second_createe_account_row___row_offset)
                    (account-undo-deployment-status-update           CREATE_second_createe_account_row___row_offset    CREATE_first_createe_account_row___row_offset)
                    (account-same-marked-for-selfdestruct            CREATE_second_createe_account_row___row_offset)
                    (vanishes!    (shift    account/TRM_FLAG         CREATE_second_createe_account_row___row_offset))
                    (vanishes!    (shift    account/ROMLEX_FLAG      CREATE_second_createe_account_row___row_offset))
                    (vanishes!    (shift    account/RLPADDR_FLAG     CREATE_second_createe_account_row___row_offset))    ;; TODO: these 3 bit vanishing constraints could be merged
                    (revert-dom-sub-stamps                           CREATE_second_createe_account_row___row_offset    1)
                    ))

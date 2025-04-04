(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                            ;;
;;   X     TX_INIT phase                      ;;
;;   X.Y   Common constraints                 ;;
;;   X.Y.Z Coinbase warm                      ;;
;;                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint   tx-init---account-row---coinbase-warm
                 (:guard (tx-init---standard-precondition))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (begin
                   (eq!     (shift account/ADDRESS_HI               tx-init---row-offset---ACC---coinbase-warm)     
                            (shift transaction/COINBASE_ADDRESS_HI  tx-init---row-offset---TXN))
                   (eq!     (shift account/ADDRESS_LO               tx-init---row-offset---ACC---coinbase-warm)     
                            (shift transaction/COINBASE_ADDRESS_LO  tx-init---row-offset---TXN))
                   (account-trim-address                          tx-init---row-offset---ACC---coinbase-warm
                                                                  account/ADDRESS_HI
                                                                  account/ADDRESS_LO)
                   (account-same-balance                          tx-init---row-offset---ACC---coinbase-warm)
                   (account-same-nonce                         tx-init---row-offset---ACC---coinbase-warm)
                   (account-same-code                          tx-init---row-offset---ACC---coinbase-warm)
                   (account-same-deployment-number-and-status  tx-init---row-offset---ACC---coinbase-warm)
                   (account-turn-on-warmth                        tx-init---row-offset---ACC---coinbase-warm)
                   (account-same-marked-for-selfdestruct          tx-init---row-offset---ACC---coinbase-warm)
                   ;; (account-retrieve-code-fragment-index          tx-init---row-offset---ACC---coinbase-warm)
                   ;; (account-isnt-precompile                       tx-init---row-offset---ACC---coinbase-warm)
                   (DOM-SUB-stamps---standard                     tx-init---row-offset---ACC---coinbase-warm
                                                                  0)))


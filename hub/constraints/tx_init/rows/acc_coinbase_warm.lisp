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
                            (tx-init---coinbase-addrsee-hi))
                   (eq!     (shift account/ADDRESS_LO               tx-init---row-offset---ACC---coinbase-warm)     
                            (tx-init---coinbase-addrsee-lo))
                   (account-trim-address                          tx-init---row-offset---ACC---coinbase-warm
                                                                  (tx-init---coinbase-addrsee-hi)
                                                                  (tx-init---coinbase-addrsee-lo))
                   (account-same-balance                          tx-init---row-offset---ACC---coinbase-warm)
                   (account-same-nonce                         tx-init---row-offset---ACC---coinbase-warm)
                   (account-same-code                          tx-init---row-offset---ACC---coinbase-warm)
                   (account-same-deployment-number-and-status  tx-init---row-offset---ACC---coinbase-warm)
                   (account-turn-on-warmth                        tx-init---row-offset---ACC---coinbase-warm)
                   (account-same-marked-for-selfdestruct          tx-init---row-offset---ACC---coinbase-warm)
                   (DOM-SUB-stamps---standard                     tx-init---row-offset---ACC---coinbase-warm
                                                                  0)))

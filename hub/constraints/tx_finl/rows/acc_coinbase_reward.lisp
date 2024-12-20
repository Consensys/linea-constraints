(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              ;;
;;   X     TX_FINL phase        ;;
;;   X.Y   Common constraints   ;;
;;   X.Y.Z Coinbase reward      ;;
;;                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint   tx-finl---account-row---coinbase-reward
                 (:guard (tx-finl---standard-precondition))
                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (begin
                   (eq!     (shift account/ADDRESS_HI             tx-finl---row-offset---ACC---coinbase-reward)     (tx-finl---coinbase-address-hi))
                   (eq!     (shift account/ADDRESS_LO             tx-finl---row-offset---ACC---coinbase-reward)     (tx-finl---coinbase-address-lo))
                   (account-increment-balance-by                  tx-finl---row-offset---ACC---coinbase-reward      (tx-finl---coinbase-reward))
                   (account-same-nonce                            tx-finl---row-offset---ACC---coinbase-reward)
                   (account-same-code                             tx-finl---row-offset---ACC---coinbase-reward)
                   (account-same-deployment-number-and-status     tx-finl---row-offset---ACC---coinbase-reward)
                   (account-same-warmth                           tx-finl---row-offset---ACC---coinbase-reward)
                   (account-same-marked-for-selfdestruct          tx-finl---row-offset---ACC---coinbase-reward)
                   (DOM-SUB-stamps---finalization                 tx-finl---row-offset---ACC---coinbase-reward
                                                                  0)))
(module hub)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                          ;;
;;   X Transactions which skip evm execution                ;;
;;   X.Y The SYSI-transaction case                          ;;
;;   X.Y.Z EIP-4788 transactions                            ;;
;;   X.Y.Z.T Transaction processing                         ;;
;;   X.Y.Z.T.U Beacon root smart contract loading           ;;
;;                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ràf: sanity checks
;; ràf: transaction row

(defconstraint    tx-skip---SYSI-4788---loading-the-beacon-root-system-smart-contract
                  (:guard (tx-skip---precondition---SYSI-4788))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                 (begin
                   (account-trim-address   tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account   ;; row offset
                                           BEACON_ROOTS_ADDRESS_HI                                                    ;; high part of raw, potentially untrimmed address
                                           BEACON_ROOTS_ADDRESS_LO)                                                   ;; low  part of raw, potentially untrimmed address
                   (eq!     (shift account/ADDRESS_HI             tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account)     BEACON_ROOTS_ADDRESS_HI)
                   (eq!     (shift account/ADDRESS_LO             tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account)     BEACON_ROOTS_ADDRESS_LO)
                   (account-same-balance                          tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account)
                   (account-same-nonce                            tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account)
                   (account-same-code                             tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account)
                   (account-same-deployment-number-and-status     tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account)
                   (account-same-warmth                           tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account)
                   (account-same-marked-for-deletion              tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account)
                   (DOM-SUB-stamps---standard                     tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account
                                                                  tx-skip---SYSI-4788---row-offset---ACC---loading-the-beacon-root-account)))

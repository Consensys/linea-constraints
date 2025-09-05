(module hub)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                          ;;
;;   X Transactions which skip evm execution                ;;
;;   X.Y The SYSI-transaction case                          ;;
;;   X.Y.Z EIP-2935 transactions                            ;;
;;   X.Y.Z.T Transaction processing                         ;;
;;   X.Y.Z.T.U Store block hash in state                    ;;
;;                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint    tx-skip---SYSI-2935---storing-the-previous-block-hash-in-state
                  (:guard (tx-skip---precondition---SYSI-2935))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (if-not-zero   (tx-skip---SYSI-2935---sys-txn-is-nontrivial)
                                 (begin
                                   (eq!   (shift   storage/ADDRESS_HI              tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp)   BEACON_ROOTS_ADDRESS_HI)
                                   (eq!   (shift   storage/ADDRESS_LO              tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp)   BEACON_ROOTS_ADDRESS_LO)
                                   (eq!   (shift   storage/DEPLOYMENT_NUMBER       tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp)   (shift   account/DEPLOYMENT_NUMBER   tx-skip---SYSI-2935---row-offset---ACC---loading-the-beacon-root-account))
                                   (eq!   (shift   storage/STORAGE_KEY_HI          tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp)   0)
                                   (eq!   (shift   storage/STORAGE_KEY_LO          tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp)   (tx-skip---SYSI-2935---prev-block-number-mod-8191))
                                   (eq!   (shift   storage/VALUE_NEXT_HI           tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp)   (tx-skip---SYSI-2935---prev-block-hash-hi))
                                   (eq!   (shift   storage/VALUE_NEXT_LO           tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp)   (tx-skip---SYSI-2935---prev-block-hash-lo))
                                   (storage-same-warmth                            tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp)
                                   (DOM-SUB-stamps---standard                      tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp       ;; kappa
                                                                                   tx-skip---SYSI-2935---row-offset---STO---storing-the-time-stamp))     ;; c
                                 ))


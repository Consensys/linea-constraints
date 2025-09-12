(module hub)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                          ;;
;;   X Transactions which skip evm execution                ;;
;;   X.Y The SYSI-transaction case                          ;;
;;   X.Y.Z EIP-2935 transactions                            ;;
;;   X.Y.Z.T Peeking flag setting                           ;;
;;                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstraint    tx-skip---SYSI-2935---setting-the-peeking-flags
                  (:guard (tx-skip---precondition---SYSI-2935))
                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                  (eq!    (+    (shift    PEEK_AT_TRANSACTION    ROFF---tx-skip---SYSI-2935---TXN                                          )
                                (shift    PEEK_AT_ACCOUNT        ROFF---tx-skip---SYSI-2935---ACC---loading-the-block-hash-history-account )
                                (shift    PEEK_AT_STORAGE        ROFF---tx-skip---SYSI-2935---STO---storing-the-previous-block-hash        )
                                (shift    PEEK_AT_CONTEXT        ROFF---tx-skip---SYSI-2935---CON---final-zero-context                     ))
                          NSR---tx-skip---SYSI-2935))                                               

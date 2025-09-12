(module hub)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                          ;;
;;   X Transactions which skip evm execution                ;;
;;   X.Y The SYSI-transaction case                          ;;
;;   X.Y.Z EIP-2935 transactions                            ;;
;;                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defconst
  ROFF---tx-skip---SYSI-2935---TXN                                          0
  ROFF---tx-skip---SYSI-2935---ACC---loading-the-block-hash-history-account 1
  ROFF---tx-skip---SYSI-2935---STO---storing-the-previous-block-hash        2
  ROFF---tx-skip---SYSI-2935---CON---final-zero-context                     3
  NSR---tx-skip---SYSI-2935                                                 4
  )


(defun (tx-skip---SYSI-2935---prev-block-number-mod-8191)   (shift   [ transaction/SYST_TXN_DATA   1 ]   ROFF---tx-skip---SYSI-2935---TXN)) ;; ""
(defun (tx-skip---SYSI-2935---prev-block-hash-hi)           (shift   [ transaction/SYST_TXN_DATA   2 ]   ROFF---tx-skip---SYSI-2935---TXN)) ;; ""
(defun (tx-skip---SYSI-2935---prev-block-hash-lo)           (shift   [ transaction/SYST_TXN_DATA   3 ]   ROFF---tx-skip---SYSI-2935---TXN)) ;; ""


(defun    (tx-skip---precondition---SYSI-2935)    (*   (-    TOTL_TXN_NUMBER    (prev    TOTL_TXN_NUMBER))
                                                       SYSI
                                                       TX_SKIP
                                                       (shift    transaction/EIP_2935    ROFF---tx-skip---SYSI-2935---TXN)
                                                       ))

(module hub)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                          ;;
;;   X Transactions which skip evm execution                ;;
;;   X.Y The SYSI-transaction case                          ;;
;;   X.Y.Z EIP-4788 transactions                            ;;
;;   X.Y.Z.T Shorthands                                     ;;
;;                                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defconst
  ROFF---tx-skip---SYSI-4788---TXN                                     0
  ROFF---tx-skip---SYSI-4788---ACC---loading-the-beacon-root-account   1
  ROFF---tx-skip---SYSI-4788---STO---storing-the-time-stamp            2
  ROFF---tx-skip---SYSI-4788---STO---storing-the-beacon-root           3
  ROFF---tx-skip---SYSI-4788---CON---final-zero-context                4
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  NSR---tx-skip---SYSI-4788                                            5
  )

(defun (tx-skip---SYSI-4788---timestamp)            (shift   [ transaction/SYST_TXN_DATA   1 ]   ROFF---tx-skip---SYSI-4788---TXN)) ;; ""
(defun (tx-skip---SYSI-4788---timestamp-mod-8191)   (shift   [ transaction/SYST_TXN_DATA   2 ]   ROFF---tx-skip---SYSI-4788---TXN)) ;; ""
(defun (tx-skip---SYSI-4788---beacon-root-hi)       (shift   [ transaction/SYST_TXN_DATA   3 ]   ROFF---tx-skip---SYSI-4788---TXN)) ;; ""
(defun (tx-skip---SYSI-4788---beacon-root-lo)       (shift   [ transaction/SYST_TXN_DATA   4 ]   ROFF---tx-skip---SYSI-4788---TXN)) ;; ""


(defun    (tx-skip---precondition---SYSI-4788)    (*   (-  TOTL_TXN_NUMBER  (prev  TOTL_TXN_NUMBER))
                                                       SYSI
                                                       TX_SKIP
                                                       (shift    transaction/EIP_4788    ROFF---tx-skip---SYSI-4788---TXN)
                                                       ))

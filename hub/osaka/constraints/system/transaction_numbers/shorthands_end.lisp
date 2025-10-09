(module hub)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                          ;;
;;   X.Y The XXX_TXN_NUMBER columns         ;;
;;   X.Y.Z Shorthands for transaction end   ;;
;;                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun    (force-bin (system-txn-numbers---sysi-txn-end))    (*    SYSI         TX_SKIP    CON))
(defun    (force-bin (system-txn-numbers---sysf-txn-end))    (*    SYSF         TX_SKIP    CON))
(defun    (force-bin (system-txn-numbers---user-txn-end))    (*    USER    (+   TX_SKIP
								    TX_FINL)   CON))

(defun    (system-txn-numbers---txn-end)    (force-bin (+  (system-txn-numbers---sysi-txn-end)
						  						 		   (system-txn-numbers---user-txn-end)
						  						 		   (system-txn-numbers---sysf-txn-end)
						  						  			)))


(module hub)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       ;;
;;   X   TX_INIT phase   ;;
;;   X.Y Introduction    ;;
;;   X.Y Shorthands      ;;
;;                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst
  tx-init---row-offset---last-execution-row                            -1
  tx-init---row-offset---MISC                                           0
  tx-init---row-offset---TXN                                            1
  tx-init---row-offset---ACC---sender-pay-for-gas                       2
  tx-init---row-offset---ACC---sender-value-transfer                    3
  tx-init---row-offset---ACC---recipient-value-reception                4
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  tx-init---row-offset---CON---context-initialization-row---WILL_REVERT 5
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  tx-init---row-offset---ACC---undoing-sender-value-transfer            5
  tx-init---row-offset---ACC---undoing-recipient-value-reception        6
  tx-init---row-offset---CON---context-initialization-row---WILL_REVERT 7
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  tx-init---number-of-rows---WILL_REVERT                                6
  tx-init---number-of-rows---WONT_REVERT                                8
  )

(defun    (tx-init---transaction-will-revert)    (shift    CONTEXT_WILL_REVERT    tx-init---row-offset---last-execution-row))
(defun    (tx-init---transaction-wont-revert)    (-    1    (tx-init---transaction-will-revert))
(defun    (tx-init---transaction-end-stamp)      (shift    TX_END_STAMP    tx-init---row-offset---last-execution-row))

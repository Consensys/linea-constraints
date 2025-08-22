(defun   (source-selector---TXNDATA-into-BLOCKDATA)   (txndata.HUB))
(defun   (target-selector---TXNDATA-into-BLOCKDATA)   (blockdata.IOMF))

;; recall that REL_BLOCK starts at 1 for the first block in the conflation
;; thus the actual block number is FIRST + (REL - 1) along non padding rows

(deflookup
  txndata-into-blockdata
  ; target columns
  (
   ;; number
   (* (target-selector---TXNDATA-into-BLOCKDATA) blockdata.REL_BLOCK               )
   (* (target-selector---TXNDATA-into-BLOCKDATA) blockdata.NUMBER                  )
   ;; block gas limit
   (* (target-selector---TXNDATA-into-BLOCKDATA) blockdata.BLOCK_GAS_LIMIT         )
   ;; coinbase address
   (* (target-selector---TXNDATA-into-BLOCKDATA) blockdata.COINBASE_HI             )
   (* (target-selector---TXNDATA-into-BLOCKDATA) blockdata.COINBASE_LO             )
   ;; basefee
   (* (target-selector---TXNDATA-into-BLOCKDATA) blockdata.BASEFEE                 )
   ;; timestamp
   (* (target-selector---TXNDATA-into-BLOCKDATA) blockdata.IS_TIMESTAMP            )
   (* (target-selector---TXNDATA-into-BLOCKDATA) blockdata.DATA_LO                 )
   )
  ; source columns
  (
   ;; number
   (* (source-selector---TXNDATA-into-BLOCKDATA) txndata.BLK_NUMBER                  )
   (* (source-selector---TXNDATA-into-BLOCKDATA) txndata.hub/btc_BLOCK_NUMBER        )
   ;; block gas limit
   (* (source-selector---TXNDATA-into-BLOCKDATA) txndata.hub/btc_BLOCK_GAS_LIMIT     )
   ;; coinbase address
   (* (source-selector---TXNDATA-into-BLOCKDATA) txndata.hub/btc_COINBASE_ADDRESS_HI )
   (* (source-selector---TXNDATA-into-BLOCKDATA) txndata.hub/btc_COINBASE_ADDRESS_LO )
   ;; basefee
   (* (source-selector---TXNDATA-into-BLOCKDATA) txndata.hub/btc_BASEFEE             )
   ;; timestamp
      (source-selector---TXNDATA-into-BLOCKDATA)
   (* (source-selector---TXNDATA-into-BLOCKDATA) txndata.hub/btc_TIMESTAMP           )
   ))




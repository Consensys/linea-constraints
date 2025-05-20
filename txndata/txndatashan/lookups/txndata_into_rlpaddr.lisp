(defun (sel-txndata-to-rlpaddr-shan)
  txndatashan.IS_DEP)

(deflookup
  txndata-into-rlpaddr
  ;; target columns
  (
    rlpaddr.ADDR_HI
    rlpaddr.ADDR_LO
    rlpaddr.DEP_ADDR_HI
    rlpaddr.DEP_ADDR_LO
    rlpaddr.NONCE
    rlpaddr.RECIPE_1
  )
  ;; source columns
  (
    (* txndatashan.FROM_HI (sel-txndata-to-rlpaddr-shan))
    (* txndatashan.FROM_LO (sel-txndata-to-rlpaddr-shan))
    (* txndatashan.TO_HI (sel-txndata-to-rlpaddr-shan))
    (* txndatashan.TO_LO (sel-txndata-to-rlpaddr-shan))
    (* txndatashan.NONCE (sel-txndata-to-rlpaddr-shan))
    (* txndatashan.IS_DEP (sel-txndata-to-rlpaddr-shan))
  ))



;; The source columns are the LIMB, when the CFI is not 0, in PHASE 9 of the Rlp module (data phase), not in its prefix phase, and when the LIMB is constructed (LC=1)
(defun (sel-rlpTxn-to-rom)
  (* (~ rlpTxn.CODE_FRAGMENT_INDEX) [rlpTxn.PHASE 10] (- 1 rlpTxn.IS_PREFIX) rlpTxn.LC))

(deflookup 
  rlpTxn-into-rom
  ;; target columns
  (
    rom.CODE_FRAGMENT_INDEX
    rom.LIMB
    rom.INDEX
    rom.nBYTES
  )
  ;; source columns
  (
    (* rlpTxn.CODE_FRAGMENT_INDEX (sel-rlpTxn-to-rom))
    (* rlpTxn.LIMB (sel-rlpTxn-to-rom))
    (* rlpTxn.INDEX_DATA (sel-rlpTxn-to-rom))
    (* rlpTxn.nBYTES (sel-rlpTxn-to-rom))
  ))



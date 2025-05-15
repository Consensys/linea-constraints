;; The source columns are the LIMB, when the CFI is not 0, in PHASE 9 of the Rlp module (data phase), not in its prefix phase, and when the LIMB is constructed (LC=1)
(defun (sel-rlptxn-to-rom-shan)
  (* (~ rlptxnshan.CODE_FRAGMENT_INDEX) rlptxnshan.IS_PHASE_DATA (- 1 rlptxnshan.IS_PREFIX) rlptxnshan.LC))

(deflookup
  rlptxn-into-rom
  ;; target columns
  (
    rom.CODE_FRAGMENT_INDEX
    rom.LIMB
    rom.INDEX
    rom.nBYTES
  )
  ;; source columns
  (
    (* rlptxnshan.CODE_FRAGMENT_INDEX (sel-rlptxn-to-rom-shan))
    (* rlptxnshan.LIMB (sel-rlptxn-to-rom-shan))
    (* rlptxnshan.INDEX_DATA (sel-rlptxn-to-rom-shan))
    (* rlptxnshan.nBYTES (sel-rlptxn-to-rom-shan))
  ))



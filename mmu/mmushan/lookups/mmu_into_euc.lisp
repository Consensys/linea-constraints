(defun (mmu-to-euc-selector-shan)
  (* mmushan.PRPRC mmushan.prprc/EUC_FLAG))

(deflookup
  mmu-into-euc
  ;reference columns
  (
    euc.DIVIDEND
    euc.DIVISOR
    euc.QUOTIENT
    euc.REMAINDER
    euc.CEIL
    euc.DONE
  )
  ;source columns
  (
    (* mmushan.prprc/EUC_A (mmu-to-euc-selector-shan))
    (* mmushan.prprc/EUC_B (mmu-to-euc-selector-shan))
    (* mmushan.prprc/EUC_QUOT (mmu-to-euc-selector-shan))
    (* mmushan.prprc/EUC_REM (mmu-to-euc-selector-shan))
    (* mmushan.prprc/EUC_CEIL (mmu-to-euc-selector-shan))
    (mmu-to-euc-selector-shan)
  ))



(defun (blockdata-into-euc-selector-shan) blockdatashan.EUC_FLAG)

(deflookup 
  blockdata-into-euc
  ;; target columns
  (
    euc.IOMF
    euc.DIVIDEND
    euc.DIVISOR
    euc.QUOTIENT
  )
  ;; source columns
  (
    (* 1                  (blockdata-into-euc-selector-shan))
    (* blockdatashan.ARG_1_LO (blockdata-into-euc-selector-shan))
    (* blockdatashan.ARG_2_LO (blockdata-into-euc-selector-shan))
    (* blockdatashan.RES      (blockdata-into-euc-selector-shan))
  ))


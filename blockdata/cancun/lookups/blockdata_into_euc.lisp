(defun (blockdata-into-euc-selector) blockdata.EUC_FLAG)

(defclookup 
  blockdata-into-euc
  ;; target columns
  (
    euc.DIVIDEND
    euc.DIVISOR
    euc.QUOTIENT
  )
  ;; source selector
  (blockdata-into-euc-selector)
  ;; source columns
  (
   (i64 blockdata.ARG_1_LO)
   (i64 blockdata.ARG_2_LO)
   (i64 blockdata.RES)
   ))


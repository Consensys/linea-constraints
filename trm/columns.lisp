(module trm)

(defcolumns 
  (STAMP :i3)
  (ADDR_HI :i16)
  (ADDR_LO :i16)
  (TRM_ADDR_HI :i4)
  (IS_PREC :binary@prove)
  ;;
  (CT :byte)
  (ACC_HI :i16)
  (ACC_LO :i16)
  (ACC_T :i16)
  (PBIT :binary@prove)
  (ONE :binary@prove)
  (BYTE_HI :byte@prove)
  (BYTE_LO :byte@prove))



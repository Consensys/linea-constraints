(defun (sel-rlptxn-to-blobhash) (force-bin (* rlptxn.IS_BLOB_HASH rlptxn.CMP)))

(defclookup
  rlptxn-into-blobhash
  ;; target columns
  (
    blobhash.USER_TXN_NUMBER
    blobhash.TOT_NUMBER_OF_HASHES
    blobhash.HASH_INDEX
    blobhash.BLOB_VERSION_HASH
  )
  ;; source selector
  (sel-rlptxn-to-blobhash)
  ;; source columns
  (
    rlptxn.USER_TXN_NUMBER
    rlptxn.cmp/AUX_CCC_1 ;; TOT number of hashes
    rlptxn.cmp/AUX_CCC_2 ;; INDEX
    (::  rlptxn.cmp/EXO_DATA_1 rlptxn.cmp/EXO_DATA_2)
  ))
(module mxpcan)

(defcolumns
  ( MXP_STAMP   :i16          )
  ( CN          :i16          )
  ( DECODER     :binary@prove )
  ( MACRO       :binary@prove )
  ( SCENARIO    :binary@prove )
  ( COMPUTATION :binary@prove )
  ( CT          :i4           )
  ( CT_MAX      :i4           )
  )

(defalias
  DECDR  DECODER
  SCNRI  SCENARIO
  CMPTN  COMPUTATION
  )
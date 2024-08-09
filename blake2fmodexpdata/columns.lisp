(module blake2fmodexpdata)

(defcolumns 
  (STAMP                :i10)
  (ID                   :i32)
  (PHASE                :byte)
  (INDEX                :byte :display :dec)
  (INDEX_MAX            :byte :display :dec)
  (LIMB                 :i128 :display :bytes)
  (IS_MODEXP_BASE       :binary@prove)
  (IS_MODEXP_EXPONENT   :binary@prove)
  (IS_MODEXP_MODULUS    :binary@prove)
  (IS_MODEXP_RESULT     :binary@prove)
  (IS_BLAKE_DATA        :binary@prove)
  (IS_BLAKE_PARAMS      :binary@prove)
  (IS_BLAKE_RESULT      :binary@prove)
  )


(module rlpAddr)

(defcolumns 
  ;; INPUTS
  RECIPE
  (RECIPE_1 :bool)
  (RECIPE_2 :bool)
  ADDR_HI     ;; hi part (4B)  of the creator address
  ADDR_LO     ;; lo part (16B) "
  DEP_ADDR_HI ;; hi part of the deploed addr
  DEP_ADDR_LO ;; lo part of "
  NONCE       ;; nonce (1-8B)  "
  SALT_HI
  SALT_LO
  KEC_HI
  KEC_LO
  ;; OUTPUTS
  LIMB        ;; bytes of the output
  (LC :bool)
  nBYTES      ;; the number of bytes to read
  INDEX
  ;; Register columns
  STAMP
  ct
  (BYTE1 :byte)
  ACC
  ACC_BYTESIZE
  POWER
  (BIT1 :bool)
  (BIT_ACC :byte)
  (TINY_NONE_ZERO_NONCE :bool))


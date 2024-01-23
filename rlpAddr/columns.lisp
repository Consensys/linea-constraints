(module rlpAddr)

(defcolumns 
  ;; INPUTS
  (RECIPE :byte)
  (RECIPE_1 :binary@prove)
  (RECIPE_2 :binary@prove)
  (ADDR_HI :i4)     ;; hi part (4B)  of the creator address
  (ADDR_LO :i16)     ;; lo part (16B) "
  (DEP_ADDR_HI :i4) ;; hi part of the deploed addr
  (DEP_ADDR_LO :i16) ;; lo part of "
  (NONCE :i8)       ;; nonce (1-8B)  "
  (SALT_HI :i16)
  (SALT_LO :i16)
  (KEC_HI :i16)
  (KEC_LO :i16)
  ;; OUTPUTS
  (LIMB :i16)        ;; bytes of the output
  (LC :binary@prove)
  (nBYTES :byte)      ;; the number of bytes to read
  (INDEX :byte)
  ;; Register columns
  (STAMP :i3)
  (COUNTER :byte)
  (BYTE1 :byte@prove)
  (ACC :i8)
  (ACC_BYTESIZE :byte)
  POWER
  (BIT1 :binary@prove)
  (BIT_ACC :byte)
  (TINY_NON_ZERO_NONCE :binary@prove))

;; aliases
(defalias 
  ct COUNTER)



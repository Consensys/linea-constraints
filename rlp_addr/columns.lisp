(module rlpAddr)

(defcolumns
  ;; INPUTS
  
  (create2 :bool)
  ADDR_HI  ;; hi part (4B)  of the creator address
  ADDR_LO ;; lo part (16B) "
  NONCE   ;; nonce (1-8B)  "
  SALT_HI 
  SALT_LO
  KEC_HI
  KEC_LO
  
  ;; OUTPUTS
  LIMB  ;; bytes of the output
  (LC :bool)
  nBYTES             ;; the number of bytes to read
  INDEX

  ;; Register columns
  STAMP
  ct                          ;; rhytm of an RLP encoding operation (16 lines)
  (BYTE :BYTE)
  ACC
  ACC_BYTESIZE
  POWER
  (BIT :bool)
  (BIT_ACC :BYTE)
  (not_little :bool))
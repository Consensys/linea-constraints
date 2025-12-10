;; BLOCKDATA module

;; The BLOCKDATA module is responsible for storing block-constant values:
;; 1. COINBASE     
;; 2. TIMESTAMP       
;; 3. NUMBER
;; 4. PREVRANDAO      
;; 5. GASLIMIT
;; 6. CHAINID
;; 7. BASEFEE
;; 8. BLOBBASEFEE

pub fn bin(INST=0x43 u8, BLOCK_NUMBER u32, VALUE u256, ARGUMENT_1 u256) -> (VALUE_NEXT_BLOCK u256) {

  if INST==EVM_INST_COINBASE     goto coinbase
  if INST==EVM_INST_TIMESTAMP    goto timestamp ;;TODO
  if INST==EVM_INST_NUMBER       goto number
  if INST==EVM_INST_PREVRANDAO   goto prevrandao          
  if INST==EVM_INST_GASLIMIT     goto gaslimit
  if INST==EVM_INST_CHAINID      goto chainid
  if INST==EVM_INST_BASEFEE      goto basefee
  if INST==EVM_INST_BLOBBASEFEE  goto blobbasefee
  goto exit_f

  var b u1

exit_f:
    fail
coinbase:
;; nothing to do
    return
timestamp:
;; need to prove a (strict) increase of timestamp
    var tmp u256
    b, tmp = VALUE_NEXT_BLOCK - VALUE - 1
    if b == 1 exit_f
    return
number:
;; prove the value of BLOCK_NUMBER
    if BLOCK_NUMBER != VALUE exit_f
;; block number increases by 1
    b, VALUE_NEXT_BLOCK = VALUE + 1
    if b != 0
    exit_f
   return
prevrandao:
;; nothing to prove
   return
gaslimit:
   ;; TODO
   return
chainid:
;; prove constancy
    if VALUE_NEXT_BLOCK != VALUE exit_f
    return
basefee:
;; TODO
  return
blobbasefee:
;; TODO
  return
}
  
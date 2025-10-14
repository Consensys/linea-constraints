(deflookup
  rom-into-instdecoder
  ;; target columns
  (
    instdecoder.OPCODE
    instdecoder.IS_PUSH
    instdecoder.IS_JUMPDEST
  )
  ;; source columns
  (
    rom.OPCODE
    rom.OPCODE_IS_PUSH
    rom.OPCODE_IS_JUMPDEST
  ))



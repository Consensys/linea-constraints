(module rom)

(defcolumns 
  (CODE_FRAGMENT_INDEX :i4)
  (CODE_FRAGMENT_INDEX_INFTY :i4)
  (CODE_SIZE :i4)
  (CODESIZE_REACHED :binary@prove)
  (PROGRAMME_COUNTER :i4)
  (LIMB :i16)
  (nBYTES :byte)
  (nBYTES_ACC :byte)
  (INDEX :i4)
  (COUNTER :byte)
  (COUNTER_MAX :byte)
  (PADDED_BYTECODE_BYTE :byte)
  (ACC :i16)
  (IS_PUSH :binary)
  (PUSH_PARAMETER :byte)
  (COUNTER_PUSH :byte)
  (IS_PUSH_DATA :binary@prove)
  (PUSH_VALUE_HIGH :i16)
  (PUSH_VALUE_LOW  :i16)
  (PUSH_VALUE_ACC  :i16)
  (PUSH_FUNNEL_BIT :binary@prove)
  (OPCODE :byte)
  (VALID_JUMP_DESTINATION :binary))

(defalias 
  PC   PROGRAMME_COUNTER
  CFI  CODE_FRAGMENT_INDEX
  CT   COUNTER
  PBCB PADDED_BYTECODE_BYTE)



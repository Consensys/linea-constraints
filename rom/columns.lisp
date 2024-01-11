(module rom)

(defcolumns
  ;; these define the loading scenarios
  (IS_INITCODE :binary)

  ;; for navigating between code fragments
  SC_ADDRESS_HI
  SC_ADDRESS_LO
  ADDRESS_INDEX
  CODE_FRAGMENT_INDEX

  ;; beating heart of a code fragment
  COUNTER
  (CYCLIC_BIT :binary)

  ;; byte code "metadata"
  CODESIZE
  CODEHASH_HI
  CODEHASH_LO
  CURRENT_CODEWORD

  ;; related to constructing push values
  (IS_PUSH			:binary)
  (IS_PUSH_DATA		:binary)
  PUSH_PARAMETER
  PUSH_PARAMETER_OFFSET
  PUSH_VALUE_HI
  PUSH_VALUE_LO
  PUSH_VALUE_ACC_HI
  PUSH_VALUE_ACC_LO
  (PUSH_FUNNEL_BIT	:binary)

  ;; related to bytecode itself and padding
  (PADDED_BYTECODE_BYTE		:BYTE)
  (OPCODE					:BYTE)
  (PADDING_BIT		:binary)
  PC
  (CODESIZE_REACHED	:binary)
  (IS_BYTECODE		:binary))

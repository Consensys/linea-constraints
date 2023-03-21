(module mmio)

(defcolumns
	CN_A
	CN_B
	CN_C
	
	INDEX_A
	INDEX_B
	INDEX_C

	VAL_A
	VAL_B
	VAL_C

	VAL_A_NEW
	VAL_B_NEW
	VAL_C_NEW

	(BYTE_A :BYTE)
	(BYTE_B :BYTE)
	(BYTE_C :BYTE)

	ACC_A
	ACC_B
	ACC_C

	MICRO_INSTRUCTION_STAMP
	MICRO_INSTRUCTION

	CONTEXT_SOURCE
	CONTEXT_TARGET

	(IS_INIT :BOOLEAN)

	SOURCE_LIMB_OFFSET
	TARGET_LIMB_OFFSET
	SOURCE_BYTE_OFFSET
	TARGET_BYTE_OFFSET

	SIZE
	(FAST :BOOLEAN)
	(ERF :BOOLEAN)
	
	STACK_VALUE_HIGH
	STACK_VALUE_LOW

	(STACK_VALUE_LO_BYTE :BYTE)
	(STACK_VALUE_HI_BYTE :BYTE)

	ACC_VAL_HI
	ACC_VAL_LO

	(EXO_IS_ROM :BOOLEAN)
	(EXO_IS_LOG :BOOLEAN)
	(EXO_IS_HASH :BOOLEAN)		;previously EXO_IS_SHA3
	(EXO_IS_TXCD :BOOLEAN)

	INDEX_X
	VAL_X
	(BYTE_X :BYTE)
	ACC_X

	TX_NUM
	LOG_NUM ;to be replaced with a single NUM column

	(BIN_1 :BOOLEAN)
	(BIN_2 :BOOLEAN)
	(BIN_3 :BOOLEAN)
	(BIN_4 :BOOLEAN)
	(BIN_5 :BOOLEAN)

	ACC_1
	ACC_2
	ACC_3
	ACC_4
	ACC_5
	ACC_6

	POW_256_1
	POW_256_2
	
	COUNTER
)

(defalias
    MICRO_STAMP     MICRO_INSTRUCTION_STAMP
    MICRO_INST      MICRO_INSTRUCTION
    CT              COUNTER
    CN_S            CONTEXT_SOURCE
    CN_T            CONTEXT_TARGET
    SLO             SOURCE_LIMB_OFFSET
    SBO             SOURCE_BYTE_OFFSET
    TLO             TARGET_LIMB_OFFSET
    TBO             TARGET_BYTE_OFFSET
    VAL_HI          STACK_VALUE_HIGH
    VAL_LO          STACK_VALUE_LOW
    BYTE_HI         STACK_VALUE_HI_BYTE
    BYTE_LO         STACK_VALUE_LO_BYTE)
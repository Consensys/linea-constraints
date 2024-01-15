(module mmu)

(defcolumns
	RAM_STAMP 
	MICRO_INSTRUCTION_STAMP
	(IS_MICRO_INSTRUCTION :binary) 

	OFF_1_LO
	OFF_2_HI
	OFF_2_LO

	SIZE_IMPORTED

	VAL_HI
	VAL_LO

	CONTEXT_NUMBER
	CALLER
	RETURNER
	CONTEXT_SOURCE
	CONTEXT_TARGET

	COUNTER
	(OFFSET_OUT_OF_BOUNDS :binary)

	PRECOMPUTATION
	TERNARY
	MICRO_INSTRUCTION
	(EXO_IS_ROM :binary)
	(EXO_IS_LOG :binary)
	(EXO_IS_HASH :binary)
	(EXO_IS_TXCD :binary)

	SOURCE_LIMB_OFFSET
	SOURCE_BYTE_OFFSET
	TARGET_LIMB_OFFSET
	TARGET_BYTE_OFFSET
	SIZE
  
	(NIB_1 :NIBBLE)
	(NIB_2 :NIBBLE)
	(NIB_3 :NIBBLE)
	(NIB_4 :NIBBLE)
	(NIB_5 :NIBBLE)
	(NIB_6 :NIBBLE)
	(NIB_7 :NIBBLE)
	(NIB_8 :NIBBLE)
	(NIB_9 :NIBBLE)

    (BYTE_1 :byte)
	(BYTE_2 :byte)
	(BYTE_3 :byte)
	(BYTE_4 :byte)
	(BYTE_5 :byte)
	(BYTE_6 :byte)
	(BYTE_7 :byte)
	(BYTE_8 :byte)

    ACC_1
    ACC_2
    ACC_3
    ACC_4
    ACC_5
    ACC_6
    ACC_7
    ACC_8

    (BIT_1 :binary)
	(BIT_2 :binary)
	(BIT_3 :binary)
	(BIT_4 :binary)
	(BIT_5 :binary)
	(BIT_6 :binary)
	(BIT_7 :binary)
	(BIT_8 :binary)

	ALIGNED
	FAST

	MIN

	CALL_STACK_DEPTH
	CALL_DATA_SIZE
	CALL_DATA_OFFSET
	INSTRUCTION
	
	TOTAL_NUMBER_OF_MICRO_INSTRUCTIONS
	TOTAL_NUMBER_OF_READS
	TOTAL_NUMBER_OF_PADDINGS

	(TO_RAM :binary)
	(ERF    :binary)

	RETURN_OFFSET
	RETURN_CAPACITY

	REFS
	REFO

	INFO

	(IS_DATA :binary))

(defalias 
	CSD				CALL_STACK_DEPTH
	CDS				CALL_DATA_SIZE
	CDO				CALL_DATA_OFFSET
	INST			INSTRUCTION
	CN				CONTEXT_NUMBER
	CN_S			CONTEXT_SOURCE
	CN_T			CONTEXT_TARGET
	TERN			TERNARY
	TOT				TOTAL_NUMBER_OF_MICRO_INSTRUCTIONS
	TOTRD			TOTAL_NUMBER_OF_READS
	TOTPD			TOTAL_NUMBER_OF_PADDINGS
	OFFOOB			OFFSET_OUT_OF_BOUNDS
	IS_MICRO		IS_MICRO_INSTRUCTION
	PRE				PRECOMPUTATION
	CT				COUNTER
	MICRO_STAMP		MICRO_INSTRUCTION_STAMP
	MICRO_INST		MICRO_INSTRUCTION
	SLO				SOURCE_LIMB_OFFSET
	SBO				SOURCE_BYTE_OFFSET
	TLO				TARGET_LIMB_OFFSET
	TBO				TARGET_BYTE_OFFSET)
(module mxp)
(defcolumns
	MEMORY_EXPANSION_STAMP
	MEMORY_EXPANSION_TYPE
	(MEMORY_EXPANSION_EXCEPTION	:BOOLEAN)
	(RIDICULOUSLY_OUT_OF_BOUND	:BOOLEAN)
	(NOOP	:BOOLEAN)
	COUNTER
	CN
	VAL_HI_1
	VAL_LO_1
	VAL_HI_2
	VAL_LO_2
	VAL_HI_3
	VAL_LO_3
	VAL_HI_4
	VAL_LO_4
	(BYTE :byte :array[8])
	(ACC :array[6])
	MSIZE
	MSIZE_NEW
	MEMORY_EXPANSION_COST
	MEMORY_EXPANSION_COST_NEW
	DELTA_MEMORY_EXPANSION_COST
	SIZE_IN_EVM_WORDS
	(COMP	:BOOLEAN)
	MAX_OFFSET
	(MEMORY_EXPANSION_EVENT	:BOOLEAN))

;; aliases
(defalias
	STAMP		MEMORY_EXPANSION_STAMP
	MXT			MEMORY_EXPANSION_TYPE
	MXX			MEMORY_EXPANSION_EXCEPTION
	ROOB		RIDICULOUSLY_OUT_OF_BOUND
	CT			COUNTER
	MXC			MEMORY_EXPANSION_COST
	MXC_NEW		MEMORY_EXPANSION_COST_NEW
	DELTA_MXC	DELTA_MEMORY_EXPANSION_COST
	SEVMW		SIZE_IN_EVM_WORDS
	MXE			MEMORY_EXPANSION_EVENT)
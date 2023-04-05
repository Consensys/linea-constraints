(module mxp)
(defcolumns
	MEMORY_EXPANSION_STAMP
	CN
	COUNTER
	(RIDICULOUSLY_OUT_OF_BOUND	:BOOLEAN)
	(NOOP	:BOOLEAN)
	(MEMORY_EXPANSION_EXCEPTION	:BOOLEAN)
	MXP_INST
	(MXP_TYPE :BOOLEAN :array[1:5])
	OFFSET_1_LO
	OFFSET_2_LO
	OFFSET_1_HI
	OFFSET_2_HI
	SIZE_1_LO
	SIZE_2_LO
	SIZE_1_HI
	SIZE_2_HI
	MAX_OFFSET_1
	MAX_OFFSET_2
	COMP
	MAX_OFFSET
	(BYTE :byte :array[1:4])
	(BYTE_A	:byte)
	(BYTE_W	:byte)
	(BYTE_Q	:byte)
	(ACC :array[1:4])
	ACC_A
	ACC_W
	ACC_Q
	BYTE_QQ
	BYTE_R
	WORDS
	WORDS_NEW
	MXPC
	MXPC_NEW
	DELTA_MXPC
	(MEMORY_EXPANSION_EVENT	:BOOLEAN)
	MXP_GBYTE
	MXP_GWORD)

;; aliases
(defalias
	STAMP		MEMORY_EXPANSION_STAMP
	CT			COUNTER
	ROOB		RIDICULOUSLY_OUT_OF_BOUND
	MXPX		MEMORY_EXPANSION_EXCEPTION
	MXPE			MEMORY_EXPANSION_EVENT)
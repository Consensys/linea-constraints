(module mmu)

(defcolumns 

;;shared columns
(STAMP :i16)
(MMIO_STAMP :i24)

;; PERSPECTIVE SELECTOR
(MACRO :binary@prove)
(PRPRC :binary@prove)
(MICRO :binary@prove)

;; OUTPUT OF THE PREPROCESSING
TOT
TOTLZ
TOTNT
TOTRZ
(OUT :array [5]) ;;TODO put right limit
(BIN :binary@prove :array [5]) ;;TODO put right limit

;; MMU INSTRUCTION FLAG
(IS_MLOAD :binary@prove)
(IS_MSTORE :binary@prove)
(IS_MSTORE8 :binary@prove)
(IS_INVALID_CODE_PREFIX :binary@prove)
(IS_RIGHT_PADDED_WORD_EXTRACTION :binary@prove)
(IS_RAM_TO_EXO_WITH_PADDING :binary@prove)
(IS_EXO_TO-RAM_TRANSPLANTS :binary@prove)
(IS_RAM_TO_RAM_SANS_PADDING :binary@prove)
(IS_ANY_TO_RAM_WITH_PADDING :binary@prove)
(IS_MODEXP_ZERO :binary@prove)
(IS_MODEXP_DATA :binary@prove)
(IS_BLAKE_PARAM :binary@prove)


;; USED ONLY IN MICRO ROW BUT ARE SHARED 
LZRO
NT_ONLY
NT_FIRST
NT_MDDL
NT_LAST
RZ_ONLY
RZ_FIRST
RZ_MDDL
RZ_LAST)

(defperspective macro 
	;; selector
	MACRO
	
	(
	 (INST :i16)
	 SRC_ID
	 TGT_ID
	 AUX_ID
	 (SRC_OFFSET_HI :i128)
	 (SRC_OFFSET_LO :i128)
	 (TGT_OFFSET_LO :i64)
	 (SIZE :i64)
	 (REF_OFFSET :i64)
	 (REF_SIZE :i64)
	 (SUCCESS_BIT :binary)
	 (LIMB_1 :i128)
	 (LIMB_2 :i128)
	 PHASE
	 EXO_SUM)
	)

(defperspective prprc 
	;; selector
	PRPRC
	
	(
		CT
		(EUC_FLAG :binary)
		(EUC_A :i64)
		(EUC_B :i64)
		(EUC_QUOT :i64)
		(EUC_REM :i64)
		(EUC_CEIL :i64)
		(WCP_FLAG :binary)
		(WCP_ARG_1_HI :i128)
		(WCP_ARG_1_LO :i128)
		(WCP_ARG_2_HI :i128)
		(WCP_ARG_2_LO :i128)
		(WCP_RES :binary)
		(WCP_INST :byte :display :opcode))
	)

	(defperspective micro 
	;; selector
	MICRO
	
	(
	INST
	(SIZE :byte)
	(SLO :i56)
	(SBO :i5)
	(TLO :i56)
	(TBO :i5)
	(LIMB_1 :i128)
	(LIMB_2 :i128)
	CN_S
	CN_T
	(SUCCESS_BIT :binary)
	EXO_SUM
	PHASE
	ID_1
	ID_2))

GO_CORSET ?= go-corset
GIT_COMMIT := $(shell git rev-parse HEAD)
GIT_TAGS := $(shell git -P tag --points-at)
TIMESTAMP := $(shell date)
GO_CORSET_COMPILE := ${GO_CORSET} compile -Dtags="${GIT_TAGS}" -Dcommit="${GIT_COMMIT}" -Dtimestamp="${TIMESTAMP}"

# Modules setting
## Some modules set below are fork specific. Eg. For OOB, OOB_LON is the OOB module for London and OOB_SHAN the OOB module for Shanghai.
## The discrimination is done by having one bin file per fork - see command line below

ALU := alu

BIN := bin   

BLAKE2f_MODEXP_DATA := blake2fmodexpdata

# constraints used in prod for LINEA, with linea block gas limit
BLOCKDATA := $(wildcard blockdata/*.lisp) \
	       $(wildcard blockdata/processing/*.lisp) \
	       $(wildcard blockdata/processing/gaslimit/common.lisp) \
	       $(wildcard blockdata/processing/gaslimit/linea.lisp) \
	       $(wildcard blockdata/lookups/*.lisp)

BLOCKHASH := blockhash

CONSTANTS := constants/constants.lisp

EC_DATA := ecdata

EUC := euc

EXP := exp

GAS := gas

# In the folders, we filter out the shanghai files marked with _shan
HUB_LON :=  $(filter-out %_shan.lisp, $(wildcard hub/*.lisp)) \
			$(filter-out %_shan.lisp, $(wildcard hub/**/*.lisp)) \
			$(filter-out %_shan.lisp, $(wildcard hub/**/**/*.lisp)) \
			$(filter-out %_shan.lisp, $(wildcard hub/**/**/**/*.lisp)) \
			$(filter-out %_shan.lisp, $(wildcard hub/**/**/**/**/*.lisp)) \
			$(filter-out %_shan.lisp, $(wildcard hub/**/**/**/**/**/*.lisp))

# In the folders, we filter out the london files marked with _lon
HUB_SHAN :=  $(filter-out %_lon.lisp, $(wildcard hub/*.lisp)) \
           			$(filter-out %_lon.lisp, $(wildcard hub/**/*.lisp)) \
           			$(filter-out %_lon.lisp, $(wildcard hub/**/**/*.lisp)) \
           			$(filter-out %_lon.lisp, $(wildcard hub/**/**/**/*.lisp)) \
           			$(filter-out %_lon.lisp, $(wildcard hub/**/**/**/**/*.lisp)) \
           			$(filter-out %_lon.lisp, $(wildcard hub/**/**/**/**/**/*.lisp))

LIBRARY := library

LOG_DATA := logdata

LOG_INFO := loginfo

MMU :=  mmu

MMIO := mmio 

MXP := mxp

OOB_LON := $(wildcard oob/oob-lon/*.lisp) \
       	       $(wildcard oob/oob-lon/**/*.lisp) \
       	       $(wildcard oob/oob-lon/**/**/*.lisp)

OOB_SHAN := $(wildcard oob/oob-shan/*.lisp) \
       	       $(wildcard oob/oob-shan/**/*.lisp) \
       	       $(wildcard oob/oob-shan/**/**/*.lisp)

RLP_ADDR := rlpaddr

RLP_TXN := rlptxn

RLP_TXRCPT := rlptxrcpt			

ROM := rom

ROM_LEX := romlex

SHAKIRA_DATA := shakiradata

SHIFT :=  shf

STP := stp

TABLES := reftables

TRM := trm

TXN_DATA := txndata

WCP := wcp

# Corset is order sensitive - to compile, we load the constants first
ZKEVM_MODULES_LONDON := ${CONSTANTS} \
		 ${ALU} \
		 ${BIN} \
		 ${BLAKE2f_MODEXP_DATA} \
		 ${BLOCKDATA} \
		 ${BLOCKHASH} \
		 ${EC_DATA} \
		 ${EUC} \
		 ${EXP} \
		 ${GAS} \
		 ${HUB_LON} \
		 ${LIBRARY} \
		 ${LOG_DATA} \
		 ${LOG_INFO} \
		 ${MMIO} \
		 ${MMU} \
		 ${MXP} \
		 ${OOB_LON} \
		 ${RLP_ADDR} \
		 ${RLP_TXN} \
		 ${RLP_TXRCPT} \
		 ${ROM} \
		 ${ROM_LEX} \
		 ${SHAKIRA_DATA} \
		 ${SHIFT} \
		 ${STP} \
		 ${TABLES} \
		 ${TRM} \
		 ${TXN_DATA} \
		 ${WCP}

 # Corset is order sensitive - to compile, we load the constants first
 ZKEVM_MODULES_SHANGHAI := ${CONSTANTS} \
		 ${ALU} \
		 ${BIN} \
		 ${BLAKE2f_MODEXP_DATA} \
		 ${BLOCKDATA} \
		 ${BLOCKHASH} \
		 ${EC_DATA} \
		 ${EUC} \
		 ${EXP} \
		 ${GAS} \
		 ${HUB_SHAN} \
		 ${LIBRARY} \
		 ${LOG_DATA} \
		 ${LOG_INFO} \
		 ${MMIO} \
		 ${MMU} \
		 ${MXP} \
		 ${OOB_SHAN} \
		 ${RLP_ADDR} \
		 ${RLP_TXN} \
		 ${RLP_TXRCPT} \
		 ${ROM} \
		 ${ROM_LEX} \
		 ${SHAKIRA_DATA} \
		 ${SHIFT} \
		 ${STP} \
		 ${TABLES} \
		 ${TRM} \
		 ${TXN_DATA} \
		 ${WCP}

zkevm.bin: ${ZKEVM_MODULES}
	${GO_CORSET_COMPILE} -o $@ ${ZKEVM_MODULES}

zkevm_london.bin: ${ZKEVM_MODULES_LONDON}
	${GO_CORSET_COMPILE} -o $@ ${ZKEVM_MODULES_LONDON}

zkevm_shanghai.bin: ${ZKEVM_MODULES_SHANGHAI}
	${GO_CORSET_COMPILE} -o $@ ${ZKEVM_MODULES_SHANGHAI}

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

TXN_DATA_LON := $(wildcard txndata/txndata-lon/*.lisp) \
	        $(wildcard txndata/txndata-lon/**/*.lisp)

TXN_DATA_SHAN := $(wildcard txndata/txndata-shan/*.lisp) \
                 $(wildcard txndata/txndata-shan/**/*.lisp)

WCP := wcp

ZKEVM_MODULES_COMMON := ${CONSTANTS} \
		 ${ALU} \
		 ${BIN} \
		 ${BLAKE2f_MODEXP_DATA} \
		 ${BLOCKDATA} \
		 ${BLOCKHASH} \
		 ${EC_DATA} \
		 ${EUC} \
		 ${EXP} \
		 ${GAS} \
		 ${LIBRARY} \
		 ${LOG_DATA} \
		 ${LOG_INFO} \
		 ${MMIO} \
		 ${MMU} \
		 ${MXP} \
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
		 ${WCP}

ZKEVM_MODULES_LONDON := ${ZKEVM_MODULES_COMMON} \
		 ${HUB_LON} \
		 ${OOB_LON} \
		 ${TXN_DATA_LON}

 ZKEVM_MODULES_SHANGHAI := ${ZKEVM_MODULES_COMMON} \
		 ${HUB_SHAN} \
		 ${OOB_SHAN} \
		 ${TXN_DATA_SHAN}

all: zkevm_london.bin zkevm_shanghai.bin

zkevm_london.bin: ${ZKEVM_MODULES_LONDON}
	${GO_CORSET_COMPILE} -o $@ ${ZKEVM_MODULES_LONDON}

zkevm_shanghai.bin: ${ZKEVM_MODULES_SHANGHAI}
	${GO_CORSET_COMPILE} -o $@ ${ZKEVM_MODULES_SHANGHAI}

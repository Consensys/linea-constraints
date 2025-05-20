GO_CORSET ?= go-corset
GIT_COMMIT := $(shell git rev-parse HEAD)
GIT_TAGS := $(shell git -P tag --points-at)
TIMESTAMP := $(shell date)
GO_CORSET_COMPILE := ${GO_CORSET} compile -Dtags="${GIT_TAGS}" -Dcommit="${GIT_COMMIT}" -Dtimestamp="${TIMESTAMP}"

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

HUB :=  hub

LIBRARY := library

LOG_DATA := logdata

LOG_INFO := loginfo

MMU :=  mmu

MMIO := mmio 

MXP := mxp

OOBLON := $(wildcard oob/ooblon/*.lisp) \
       	       $(wildcard oob/ooblon/lookups/*.lisp) \
       	       $(wildcard oob/ooblon/opcodes/*.lisp) \
       	       $(wildcard oob/ooblon/precompiles/blake2f/*.lisp) \
       	       $(wildcard oob/ooblon/precompiles/common/*.lisp) \
       	       $(wildcard oob/ooblon/precompiles/modexp/*.lisp)

OOBSHAN := $(wildcard oob/oobshan/*.lisp) \
       	       $(wildcard oob/oobshan/lookups/*.lisp) \
       	       $(wildcard oob/oobshan/opcodes/*.lisp) \
       	       $(wildcard oob/oobshan/precompiles/blake2f/*.lisp) \
       	       $(wildcard oob/oobshan/precompiles/common/*.lisp) \
       	       $(wildcard oob/oobshan/precompiles/modexp/*.lisp)

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
		 ${HUB} \
		 ${LIBRARY} \
		 ${LOG_DATA} \
		 ${LOG_INFO} \
		 ${MMIO} \
		 ${MMU} \
		 ${MXP} \
		 ${OOBLON} \
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
		 ${HUB} \
		 ${LIBRARY} \
		 ${LOG_DATA} \
		 ${LOG_INFO} \
		 ${MMIO} \
		 ${MMU} \
		 ${MXP} \
		 ${OOBSHAN} \
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

zkevm-london.bin: ${ZKEVM_MODULES_LONDON}
	${GO_CORSET_COMPILE} -o $@ ${ZKEVM_MODULES_LONDON}

zkevm-shanghai.bin: ${ZKEVM_MODULES_SHANGHAI}
	${GO_CORSET_COMPILE} -o $@ ${ZKEVM_MODULES_SHANGHAI}

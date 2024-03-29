CORSET ?= corset

HUB :=  $(wildcard hub/columns/*lisp) \
	$(wildcard hub/constraints/account-rows/*lisp) \
	$(wildcard hub/constraints/consistency/*lisp) \
	$(wildcard hub/constraints/context-rows/*lisp) \
	$(wildcard hub/constraints/generalities/*lisp) \
	$(wildcard hub/constraints/heartbeat/*lisp) \
	$(wildcard hub/constraints/instruction-handling/*lisp) \
	$(wildcard hub/constraints/instruction-handling/halting/*lisp) \
	$(wildcard hub/constraints/instruction-handling/create/*lisp) \
	$(wildcard hub/constraints/instruction-handling/copy/*lisp) \
	$(wildcard hub/constraints/miscellaneous-rows/*lisp) \
	$(wildcard hub/constraints/scenario-rows/*lisp) \
	$(wildcard hub/constraints/storage-rows/*lisp) \
	$(wildcard hub/constraints/tx_skip/*lisp) \
	$(wildcard hub/constraints/tx_prewarm/*lisp) \
	$(wildcard hub/constraints/tx_init/*lisp) \
	$(wildcard hub/constraints/tx_finl/*lisp) \
	$(wildcard hub/constraints/*lisp) \
	$(wildcard hub/lookups/*lisp) \
	hub/constants.lisp

ALU := alu/add/columns.lisp \
       alu/add/constraints.lisp \
       alu/ext/columns.lisp \
       alu/ext/constraints.lisp \
       alu/mod/columns.lisp \
       alu/mod/constraints.lisp \
       alu/mul/columns.lisp \
       alu/mul/constraints.lisp \
       alu/mul/helpers.lisp

BIN := bin   

BLAKE2f_MODEXP_DATA := blake2f_modexp_data

CONSTANTS := constants/constants.lisp

EC_DATA := ec_data

EUC := euc

EXP := exp

GAS := gas

LIBRARY := library/rlp_constraints_pattern.lisp

LOG_DATA := logData

LOG_INFO := logInfo

MMU := mmu

MMIO := mmio \
mmio/consistency.lisp

MXP := mxp

PUB_DATA := $(shell find pub/ -iname '*.lisp')

SHAKIRA := shakira_data

RLP_ADDR := rlpAddr

RLP_TXN := rlp_txn

RLP_TXRCPT := rlp_txrcpt			

ROM := rom

ROM_LEX := romLex

SHAKIRA := shakira

SHIFT :=  shf

STP := stp

TABLES := reference_tables/binRT.lisp \
	  reference_tables/shfRT.lisp \
	  reference_tables/instruction_decoder.lisp 

TRM := trm

TXN_DATA := txn_data 

WCP := wcp

ZKEVM_MODULES := ${ALU} \
		 ${BIN} \
		 ${BLAKE2f_MODEXP_DATA} \
		 ${CONSTANTS} \
		 ${EC_DATA} \
		 ${EUC} \
		 ${EXP} \
		 ${GAS} \
		 ${HUB} \
		 ${LIBRARY} \
		 ${LOG_DATA} \
		 ${LOG_INFO} \
		 ${MMU} \
		 ${MMIO} \
		 ${MXP} \
		 ${RLP_ADDR} \
		 ${RLP_TXN} \
		 ${RLP_TXRCPT} \
		 ${ROM} \
		 ${ROM_LEX} \
		 ${SHAKIRA} \
		 ${SHIFT} \
		 ${STP} \
		 ${TABLES} \
		 ${TRM} \
		 ${TXN_DATA} \
		 ${WCP}

define.go: ${ZKEVM_MODULES}
	${CORSET} wizard-iop -vv -P define -o $@ ${ZKEVM_MODULES}
    
zkevm.bin: ${ZKEVM_MODULES}
	${CORSET} compile -vv -o $@ ${ZKEVM_MODULES}

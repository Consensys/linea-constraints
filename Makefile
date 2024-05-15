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
	$(wildcard hub/constants.lisp) \
	# hub/constants.lisp

ALU := alu/add/columns.lisp \
       alu/add/constraints.lisp \
       alu/ext/columns.lisp \
       alu/ext/constraints.lisp \
       alu/mod/columns.lisp \
	   alu/mod/constants.lisp \
       alu/mod/constraints.lisp \
       alu/mul/columns.lisp \
       alu/mul/constraints.lisp \
       alu/mul/helpers.lisp

BIN := bin   

BLAKE2f_MODEXP_DATA := blake2fmodexpdata

BLOCKDATA := blockdata

BLOCKHASH := blockhash

CONSTANTS := constants/constants.lisp

EC_DATA := ecdata

EUC := euc

EXP := exp

GAS := gas

LIBRARY := library/rlp_constraints_pattern.lisp

LOG_DATA := logdata

LOG_INFO := loginfo

MMU := mmu

MMIO := mmio/columns.lisp #TODO enable the MMIO constraint and lookup
# MMIO := mmio \
# mmio/consistency.lisp

MXP := mxp

RLP_ADDR := rlpaddr

RLP_TXN := rlptxn

RLP_TXRCPT := rlptxrcpt			

ROM := rom

ROM_LEX := romlex

SHAKIRA := shakira

SHIFT :=  shf

STP := stp

TABLES := reftables/bin_reftable.lisp \
	  reftables/shf_reftable.lisp \
	  reftables/instruction_decoder.lisp

TRM := trm

TXN_DATA := txndata

WCP := wcp

ZKEVM_MODULES := ${ALU} \
		 ${BIN} \
		 ${BLAKE2f_MODEXP_DATA} \
		 ${BLOCKDATA} \
	     ${BLOCKHASH} \
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

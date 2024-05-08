CORSET ?= corset

HUB_V2 := $(wildcard hub_v2/columns/*lisp) \
	  $(wildcard hub_v2/constraints/heartbeat/*lisp) \
	  $(wildcard hub_v2/constraints/generalities/*lisp) \
	  $(wildcard hub_v2/lookups/*lisp) \
	  hub_v2/constants.lisp

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
# alu/add/hub_into_add.lisp \
	# alu/ext/hub_into_ext.lisp \
	# alu/mod/hub_into_mod.lisp \
	# alu/mul/hub_into_mul.lisp

BIN := bin   

BLAKE2f_MODEXP_DATA := blake2fmodexpdata

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

PUB_DATA := $(shell find pub/ -iname '*.lisp')

RLP_ADDR := rlpaddr

RLP_TXN := rlptxn

RLP_TXRCPT := rlptxrcpt			

ROM := rom

ROM_LEX := romlex

SHAKIRA_DATA := shakiradata

SHIFT :=  shf

STACK := hub/columns.lisp \
	 hub/constraints.lisp

STP := stp

TABLES := reftables/bin_reftable.lisp \
	  reftables/shf_reftable.lisp \
	  reftables/inst_decoder.lisp

TRM := trm

TXN_DATA := txndata

WCP := wcp

ZKEVM_MODULES := ${ALU} \
	${BIN} \
	${BLAKE2f_MODEXP_DATA} \
	${CONSTANTS} \
	${EC_DATA} \
	${EUC} \
	${EXP} \
	${GAS} \
	${LIBRARY} \
	${LOG_DATA} \
	${LOG_INFO} \
	${MMU} \
	${MMIO} \
	${MXP} \
	${PUB_DATA} \
	${RLP_ADDR} \
	${RLP_TXN} \
	${RLP_TXRCPT} \
	${ROM} \
	${ROM_LEX} \
	${SHAKIRA_DATA} \
	${SHIFT} \
	${STACK} \
	${STP} \
	${TABLES} \
	${TRM} \
	${TXN_DATA} \
	${WCP}

define.go: ${ZKEVM_MODULES}
	${CORSET} wizard-iop -vv -P define -o $@ ${ZKEVM_MODULES}
    
zkevm.bin: ${ZKEVM_MODULES}
	${CORSET} compile -vv -o $@ ${ZKEVM_MODULES}

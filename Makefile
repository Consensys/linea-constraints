CORSET ?= corset

ALU := alu/add/columns.lisp \
	alu/add/constraints.lisp \
	alu/ext/columns.lisp \
	alu/ext/constraints.lisp \
	alu/mod/columns.lisp \
	alu/mod/constraints.lisp \
	alu/mul/columns.lisp \
	alu/mul/constraints.lisp \
	alu/mul/helpers.lisp \
#       alu/add/hub_into_add.lisp \
#       alu/ext/hub_into_ext.lisp \
#       alu/mod/hub_into_mod.lisp \
#       alu/mul/hub_into_mul.lisp

BIN := bin/columns.lisp \
	   bin/constraints.lisp \
	   $(wildcard lookup_tables/binRT/*lisp) \
	   lookup_tables/lookups/bin_into_binRT.lisp \
	   # bin/hub_into_bin.lisp \

CONSTANTS := constants/constants.lisp

EC_DATA := ec_data/columns.lisp \
	ec_data/constraints.lisp \
	ec_data/ecdata_into_ext.lisp \
	ec_data/ecdata_into_wcp.lisp \
	ec_data/hub_into_ecdata.lisp \

EUC := euc

LIBRARY := library/constant.lisp library/rlp_constraints_pattern.lisp

LOG_DATA := logData

LOG_INFO := logInfo

MEMORY := $(wildcard hub/mmio/columns.lisp) \
		  $(wildcard hub/mmu/columns.lisp) \
		  lookup_tables/mmuID/columns.lisp

MMU := mmu

MXP := mxp/columns.lisp \
	mxp/constraints.lisp \
	mxp/lookups/mxp_into_instruction_decoder.lisp
		   # mxp/lookups/hub_into_mxp.lisp

PUB_DATA := $(shell find pub/ -iname '*.lisp')

RLP_ADDR := rlpAddr

RLP_TXN := rlp_txn

RLP_TXRCPT := rlp_txrcpt			

ROM := rom/columns.lisp \
	rom/constraints.lisp \
	rom/rom_into_instructionDecoder.lisp

ROM_LEX := romLex/columns.lisp romLex/constraints.lisp \
	romLex/romLex_into_rom.lisp

SHIFT :=  shf/columns.lisp \
	shf/constraints.lisp \
	$(wildcard lookup_tables/shfRT/*lisp) \
	lookup_tables/lookups/shf_into_shfRT.lisp \
	# shf/hub_into_shf.lisp \	

STACK := hub/columns.lisp \
	hub/constraints.lisp

STP := stp/columns.lisp stp/constraints.lisp \
	stp/lookups/stp_into_mod.lisp stp/lookups/stp_into_wcp.lisp

TABLES := $(wildcard lookup_tables/tables/*lisp)

TRM := trm/columns.lisp trm/constraints.lisp

TXN_DATA := txn_data 

WCP := wcp/columns.lisp wcp/constraints.lisp \
	   # wcp/hub_into_wcp.lisp \

BLAKE2f_MODEXP_DATA := blake2f_modexp_data/

EXP := exp/columns.lisp exp/constraints.lisp exp/constants.lisp exp/exp-into-wcp.lisp

ZKEVM_MODULES := ${ALU} \
	${BIN} \
	${BLAKE2f_MODEXP_DATA} \
	${EC_DATA} \
	${EUC} \
	${CONSTANTS} \
	${LIBRARY} \
	${LOG_DATA} \
	${LOG_INFO} \
	${MEMORY} \
	${MMU} \
	${MXP} \
	${PUB_DATA} \
	${RLP_ADDR} \
	${RLP_TXN} \
	${RLP_TXRCPT} \
	${ROM} \
	${ROM_LEX} \
	${SHIFT} \
	${STACK} \
	${STP} \
	${TABLES} \
	${TRM} \
	${TXN_DATA} \
	${WCP} \
	${EXP}

define.go: ${ZKEVM_MODULES}
	${CORSET} wizard-iop -vv -P define -o $@ ${ZKEVM_MODULES}

zkevm.bin: ${ZKEVM_MODULES}
	${CORSET} compile -vv -o $@ ${ZKEVM_MODULES}

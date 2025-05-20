(defun (hub-into-instruction-decoder-trigger) hubshan.PEEK_AT_STACK)

(deflookup hub-into-instdecoder
           ;; target columns
	   (
	     instdecoder.OPCODE
	     instdecoder.STATIC_GAS
	     instdecoder.TWO_LINE_INSTRUCTION
	     instdecoder.FLAG_1
	     instdecoder.FLAG_2
	     instdecoder.FLAG_3
	     instdecoder.FLAG_4
	     instdecoder.MXP_FLAG
	     instdecoder.STATIC_FLAG
	     instdecoder.ALPHA
	     instdecoder.DELTA
	     ;;
	     instdecoder.FAMILY_ACCOUNT
	     instdecoder.FAMILY_ADD
	     instdecoder.FAMILY_BIN
	     instdecoder.FAMILY_BATCH
	     instdecoder.FAMILY_CALL
	     instdecoder.FAMILY_CONTEXT
	     instdecoder.FAMILY_COPY
	     instdecoder.FAMILY_CREATE
	     instdecoder.FAMILY_DUP
	     instdecoder.FAMILY_EXT
	     instdecoder.FAMILY_HALT
	     instdecoder.FAMILY_INVALID
	     instdecoder.FAMILY_JUMP
	     instdecoder.FAMILY_KEC
	     instdecoder.FAMILY_LOG
	     instdecoder.FAMILY_MACHINE_STATE
	     instdecoder.FAMILY_MOD
	     instdecoder.FAMILY_MUL
	     instdecoder.FAMILY_PUSH_POP
	     instdecoder.FAMILY_SHF
	     instdecoder.FAMILY_STACK_RAM
	     instdecoder.FAMILY_STORAGE
	     instdecoder.FAMILY_SWAP
	     instdecoder.FAMILY_TRANSACTION
	     instdecoder.FAMILY_WCP
	     ;;
           )

           ;; source columns
	   (
	     (* hubshan.stack/INSTRUCTION                 (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/STATIC_GAS                  (hub-into-instruction-decoder-trigger))
	     (* hubshan.TWO_LINE_INSTRUCTION              (hub-into-instruction-decoder-trigger))
	     (* [hubshan.stack/DEC_FLAG 1]                (hub-into-instruction-decoder-trigger))
	     (* [hubshan.stack/DEC_FLAG 2]                (hub-into-instruction-decoder-trigger))
	     (* [hubshan.stack/DEC_FLAG 3]                (hub-into-instruction-decoder-trigger))
	     (* [hubshan.stack/DEC_FLAG 4]                (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/MXP_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/STATIC_FLAG                 (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/ALPHA                       (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/DELTA                       (hub-into-instruction-decoder-trigger))
	     ;;
	     (* hubshan.stack/ACC_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/ADD_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/BIN_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/BTC_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/CALL_FLAG                   (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/CON_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/COPY_FLAG                   (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/CREATE_FLAG                 (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/DUP_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/EXT_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/HALT_FLAG                   (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/INVALID_FLAG                (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/JUMP_FLAG                   (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/KEC_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/LOG_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/MACHINE_STATE_FLAG          (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/MOD_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/MUL_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/PUSHPOP_FLAG                (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/SHF_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/STACKRAM_FLAG               (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/STO_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/SWAP_FLAG                   (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/TXN_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hubshan.stack/WCP_FLAG                    (hub-into-instruction-decoder-trigger))
	     ;;
           )
)

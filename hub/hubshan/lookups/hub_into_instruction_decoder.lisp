(defun (hub-into-instruction-decoder-trigger-shan) hubshan.PEEK_AT_STACK)

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
	     (* hubshan.stack/INSTRUCTION                 (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/STATIC_GAS                  (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.TWO_LINE_INSTRUCTION              (hub-into-instruction-decoder-trigger-shan))
	     (* [hubshan.stack/DEC_FLAG 1]                (hub-into-instruction-decoder-trigger-shan))
	     (* [hubshan.stack/DEC_FLAG 2]                (hub-into-instruction-decoder-trigger-shan))
	     (* [hubshan.stack/DEC_FLAG 3]                (hub-into-instruction-decoder-trigger-shan))
	     (* [hubshan.stack/DEC_FLAG 4]                (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/MXP_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/STATIC_FLAG                 (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/ALPHA                       (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/DELTA                       (hub-into-instruction-decoder-trigger-shan))
	     ;;
	     (* hubshan.stack/ACC_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/ADD_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/BIN_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/BTC_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/CALL_FLAG                   (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/CON_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/COPY_FLAG                   (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/CREATE_FLAG                 (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/DUP_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/EXT_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/HALT_FLAG                   (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/INVALID_FLAG                (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/JUMP_FLAG                   (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/KEC_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/LOG_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/MACHINE_STATE_FLAG          (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/MOD_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/MUL_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/PUSHPOP_FLAG                (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/SHF_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/STACKRAM_FLAG               (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/STO_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/SWAP_FLAG                   (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/TXN_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     (* hubshan.stack/WCP_FLAG                    (hub-into-instruction-decoder-trigger-shan))
	     ;;
           )
)

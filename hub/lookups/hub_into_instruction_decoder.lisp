(defun (hub-into-instruction-decoder-trigger) hub.PEEK_AT_STACK)

(deflookup hub-into-instruction-decoder

           ;; target columns
	   ( 
	     instruction-decoder.OPCODE
	     instruction-decoder.STATIC_GAS
	     instruction-decoder.TWO_LINE_INSTRUCTION
	     instruction-decoder.FLAG_1
	     instruction-decoder.FLAG_2
	     instruction-decoder.FLAG_3
	     instruction-decoder.FLAG_4
	     instruction-decoder.MXP_FLAG
	     instruction-decoder.STATIC_FLAG
	     instruction-decoder.ALPHA
	     instruction-decoder.DELTA
	     instruction-decoder.NB_REMOVED
	     instruction-decoder.NB_ADDED  
	     ;;
	     instruction-decoder.FAMILY_ACCOUNT
	     instruction-decoder.FAMILY_ADD
	     instruction-decoder.FAMILY_BIN
	     instruction-decoder.FAMILY_BATCH
	     instruction-decoder.FAMILY_CONTEXT
	     instruction-decoder.FAMILY_COPY
	     instruction-decoder.FAMILY_DUP
	     instruction-decoder.FAMILY_EXT
	     instruction-decoder.FAMILY_HALT
	     instruction-decoder.FAMILY_INVALID
	     instruction-decoder.FAMILY_JUMP
	     instruction-decoder.FAMILY_KEC
	     instruction-decoder.FAMILY_LOG
	     instruction-decoder.FAMILY_MACHINE_STATE
	     instruction-decoder.FAMILY_MOD
	     instruction-decoder.FAMILY_MUL
	     instruction-decoder.FAMILY_PUSH_POP
	     instruction-decoder.FAMILY_SHF
	     instruction-decoder.FAMILY_STACK_RAM
	     instruction-decoder.FAMILY_STORAGE
	     instruction-decoder.FAMILY_SWAP
	     instruction-decoder.FAMILY_TRANSACTION
	     instruction-decoder.FAMILY_WCP
	     ;;
           )

           ;; source columns
	   (
	     (* hub.stack/INSTRUCTION                 (hub-into-instruction-decoder-trigger))
	     (* hub.stack/STATIC_GAS                  (hub-into-instruction-decoder-trigger))
	     (* hub.TWO_LINE_INSTRUCTION              (hub-into-instruction-decoder-trigger))
	     (* [hub.stack/DEC_FLAG 1]                (hub-into-instruction-decoder-trigger))
	     (* [hub.stack/DEC_FLAG 2]                (hub-into-instruction-decoder-trigger))
	     (* [hub.stack/DEC_FLAG 3]                (hub-into-instruction-decoder-trigger))
	     (* [hub.stack/DEC_FLAG 4]                (hub-into-instruction-decoder-trigger))
	     (* hub.stack/MXP_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/STATIC_FLAG                 (hub-into-instruction-decoder-trigger))
	     (* hub.stack/ALPHA                       (hub-into-instruction-decoder-trigger))
	     (* hub.stack/DELTA                       (hub-into-instruction-decoder-trigger))
	     (* hub.stack/NB_REMOVED                  (hub-into-instruction-decoder-trigger))
	     (* hub.stack/NB_ADDED                    (hub-into-instruction-decoder-trigger))
	     ;;
	     (* hub.stack/ACC_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/ADD_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/BIN_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/BTC_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/CON_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/COPY_FLAG                   (hub-into-instruction-decoder-trigger))
	     (* hub.stack/DUP_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/EXT_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/HALT_FLAG                   (hub-into-instruction-decoder-trigger))
	     (* hub.stack/INVALID_FLAG                (hub-into-instruction-decoder-trigger))
	     (* hub.stack/JUMP_FLAG                   (hub-into-instruction-decoder-trigger))
	     (* hub.stack/KEC_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/LOG_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/MACHINE_STATE_FLAG          (hub-into-instruction-decoder-trigger))
	     (* hub.stack/MOD_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/MUL_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/PUSHPOP_FLAG                (hub-into-instruction-decoder-trigger))
	     (* hub.stack/SHF_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/STACKRAM_FLAG               (hub-into-instruction-decoder-trigger))
	     (* hub.stack/STO_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/SWAP_FLAG                   (hub-into-instruction-decoder-trigger))
	     (* hub.stack/TXN_FLAG                    (hub-into-instruction-decoder-trigger))
	     (* hub.stack/WCP_FLAG                    (hub-into-instruction-decoder-trigger))
	     ;;
           )
)

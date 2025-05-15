(defun (hub-into-rom-instruction-fetching-trigger-shan) hubshan.PEEK_AT_STACK)

(deflookup hub-into-rom-instruction-fetching
           ;; target columns
	   (
	     rom.CFI
	     rom.PC
	     rom.OPCODE
	     rom.PUSH_VALUE_HI
	     rom.PUSH_VALUE_LO
           )
           ;; source columns
	   (
	     (* hubshan.CFI                    (hub-into-rom-instruction-fetching-trigger-shan))
	     (* hubshan.PC                     (hub-into-rom-instruction-fetching-trigger-shan))
	     (* hubshan.stack/INSTRUCTION      (hub-into-rom-instruction-fetching-trigger-shan))
	     (* hubshan.stack/PUSH_VALUE_HI    (hub-into-rom-instruction-fetching-trigger-shan))
	     (* hubshan.stack/PUSH_VALUE_LO    (hub-into-rom-instruction-fetching-trigger-shan))
           )
)

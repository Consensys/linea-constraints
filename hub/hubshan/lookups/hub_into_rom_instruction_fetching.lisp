(defun (hub-into-rom-instruction-fetching-trigger) hubshan.PEEK_AT_STACK)

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
	     (* hubshan.CFI                    (hub-into-rom-instruction-fetching-trigger))
	     (* hubshan.PC                     (hub-into-rom-instruction-fetching-trigger))
	     (* hubshan.stack/INSTRUCTION      (hub-into-rom-instruction-fetching-trigger))
	     (* hubshan.stack/PUSH_VALUE_HI    (hub-into-rom-instruction-fetching-trigger))
	     (* hubshan.stack/PUSH_VALUE_LO    (hub-into-rom-instruction-fetching-trigger))
           )
)

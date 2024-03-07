(defun (hub-into-rom-jump-destination-vetting-trigger)
  (and hub.PEEK_AT_STACK
       hub.stack/JUMP_DESTINATION_VETTING_REQUIRED))

(deflookup hub-into-gas
           ;; target columns
	   ( 
	     rom.CFI
	     rom.OPCODE
	     rom.IS_JUMPDEST
           )
           ;; source columns
	   (
	     (* hub.CFI                    (hub-into-rom-jump-destination-vetting-trigger))
	     (* hub.stack/INSTRUCTION      (hub-into-rom-jump-destination-vetting-trigger))
	     (* (- 1 hub.stack/JUMPX)      (hub-into-rom-jump-destination-vetting-trigger))
           )
)

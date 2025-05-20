(defun (hub-into-rom-jump-destination-vetting-trigger-shan)
  (* hubshan.PEEK_AT_STACK
     hubshan.stack/JUMP_DESTINATION_VETTING_REQUIRED))

(deflookup hub-into-rom-jump-destination-vetting
           ;; target columns
	   (
	     rom.CFI
	     rom.PC
	     rom.IS_JUMPDEST
           )
           ;; source columns
	   (
	     (* hubshan.CFI                                (hub-into-rom-jump-destination-vetting-trigger-shan))
	     (* [hubshan.stack/STACK_ITEM_VALUE_LO 1]      (hub-into-rom-jump-destination-vetting-trigger-shan))
	     (* (- 1 hubshan.stack/JUMPX)                  (hub-into-rom-jump-destination-vetting-trigger-shan))
           )
)

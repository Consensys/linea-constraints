(defun (hub-into-ripsha-trigger)
  (*
    hub.PEEK_AT_STACK
    hub.stack/HASH_INFO_FLAG))

(deflookup hub-into-hash-info
	   ;; target columns
	   (
	     ripsha.PHASE
	     ripsha.ID
	     ripsha.INDEX
	     ;; ripsha.TOTAL_SIZE
	     (shift ripsha.LIMB -1)
	     ripsha.LIMB
	     )
	   ;; source columns
	   (
	    (* PHASE_KECCAK_RESULT            (hub-into-ripsha-trigger))
	    (* (+ 1 hub.HUB_STAMP)            (hub-into-ripsha-trigger))
	    (* 1                              (hub-into-ripsha-trigger)) ;; we could just write (hub-into-ripsha-trigger)
	    ;; (* hub.stack/HASH_INFO_SIZE       (hub-into-ripsha-trigger))
	    (* hub.stack/HASH_INFO_KECCAK_HI     (hub-into-ripsha-trigger))
	    (* hub.stack/HASH_INFO_KECCAK_LO     (hub-into-ripsha-trigger))
	    )
	   )

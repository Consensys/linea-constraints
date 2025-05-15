(defun (hub-into-oob-trigger)
  (* hub.PEEK_AT_MISCELLANEOUS
     hub.misc/OOB_FLAG))

(deflookup hub-into-oob
           ;; target columns
	   (
	     ooblon.OOB_INST
	     [ooblon.DATA 1]
	     [ooblon.DATA 2]
	     [ooblon.DATA 3]
	     [ooblon.DATA 4]
	     [ooblon.DATA 5]
	     [ooblon.DATA 6]
	     [ooblon.DATA 7]
	     [ooblon.DATA 8]
	     [ooblon.DATA 9]
           )
           ;; source columns
	   (
	     (* hub.misc/OOB_INST               (hub-into-oob-trigger))
	     (* [hub.misc/OOB_DATA 1]           (hub-into-oob-trigger))
	     (* [hub.misc/OOB_DATA 2]           (hub-into-oob-trigger))
	     (* [hub.misc/OOB_DATA 3]           (hub-into-oob-trigger))
	     (* [hub.misc/OOB_DATA 4]           (hub-into-oob-trigger))
	     (* [hub.misc/OOB_DATA 5]           (hub-into-oob-trigger))
	     (* [hub.misc/OOB_DATA 6]           (hub-into-oob-trigger))
	     (* [hub.misc/OOB_DATA 7]           (hub-into-oob-trigger))
	     (* [hub.misc/OOB_DATA 8]           (hub-into-oob-trigger))
	     (* [hub.misc/OOB_DATA 9]           (hub-into-oob-trigger))
           )
)

(defun (hub-into-oob-trigger-shan)
  (* hubshan.PEEK_AT_MISCELLANEOUS
     hubshan.misc/OOB_FLAG))

(deflookup hub-into-oob
           ;; target columns
	   (
	     oobshan.OOB_INST
	     [oobshan.DATA  1]
	     [oobshan.DATA  2]
	     [oobshan.DATA  3]
	     [oobshan.DATA  4]
	     [oobshan.DATA  5]
	     [oobshan.DATA  6]
	     [oobshan.DATA  7]
	     [oobshan.DATA  8]
	     [oobshan.DATA  9]
	     [oobshan.DATA 10]
           )
           ;; source columns
	   (
	     (*  hubshan.misc/OOB_INST               (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA  1]           (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA  2]           (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA  3]           (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA  4]           (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA  5]           (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA  6]           (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA  7]           (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA  8]           (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA  9]           (hub-into-oob-trigger-shan))
	     (* [hubshan.misc/OOB_DATA 10]           (hub-into-oob-trigger-shan))
           )
)
